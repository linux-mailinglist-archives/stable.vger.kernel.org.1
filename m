Return-Path: <stable+bounces-206256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 863B5D01614
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 08:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D437300F896
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 07:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A8D275B15;
	Thu,  8 Jan 2026 07:20:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BEA1CBEB9;
	Thu,  8 Jan 2026 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767856818; cv=none; b=ILhxzNbytzTrucQB6qV+O2Ptin20QP9tRFowfGJWXpT5VE/lP8sQXB6hph0N78uALMdRx0i4MMmklpVDRTeoB1vKICoIa7Zm9zphYs8MkWA23iQ71/2dRruXL429y4uBfbUu/wIzHQbW2/B9c2Wy04nWFpK0Gzzey6FcU09WE40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767856818; c=relaxed/simple;
	bh=NmMznqo4R1hvzUpYW4o9pke/Weh0wWD6Hth23nJsg80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phsmX/VPZT3QRT2Z05P02J8Dj4zmkD3giqRr92JlsVzqCUdCQe7w0rxjFvS75BJ9yW5+zZ4RommmMj2Bl8Mb9jtmfkwFkYXpHV+14zbGPdR2VInjbaMmPOvOkoji2Ak6rmUvG8Vqu7Phzp7r4fcGrCh+BzOWyBzb/ueDhx9BHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-05 (Coremail) with SMTP id zQCowAA3yQyoWl9p8pn3Aw--.46387S2;
	Thu, 08 Jan 2026 15:20:08 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: oak.zeng@amd.com
Cc: Alexander.Deucher@amd.com,
	Christian.Koenig@amd.com,
	Felix.Kuehling@amd.com,
	airlied@gmail.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	lihaoxiang@isrc.iscas.ac.cn,
	linux-kernel@vger.kernel.org,
	simona@ffwll.ch,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/amdkfd: fix a memory leak in device_queue_manager_init()
Date: Thu,  8 Jan 2026 15:20:07 +0800
Message-Id: <20260108072007.299229-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <BYAPR12MB3176BA15327312EC21B8ED228085A@BYAPR12MB3176.namprd12.prod.outlook.com>
References: <BYAPR12MB3176BA15327312EC21B8ED228085A@BYAPR12MB3176.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3yQyoWl9p8pn3Aw--.46387S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYB7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aV
	CY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI
	0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBgoBE2lfTzYmIQAAsW

On Thu, 8 Jan 2026 02:15:12 +0000, Zeng wrote:
> } in last line should be in a new line.

Hi, Zeng! I rechecked my patch and found that this issue does not
appear in the version I submitted. I’m not sure why this discrepancy
occurred, but I’ve sent a v3 revision anyway and hope it now shows
up correctly.

> Other than that, patch lgtm. Reviewed-by: Oak.Zeng@amd.com

Thanks for review!

Thanks,
Haoxiang Li  


