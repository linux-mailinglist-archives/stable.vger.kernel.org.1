Return-Path: <stable+bounces-192138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BBBC29D91
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 03:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E473AF925
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 02:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EF4184524;
	Mon,  3 Nov 2025 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ZOwvOI38"
X-Original-To: stable@vger.kernel.org
Received: from zg8tmty1ljiyny4xntuumtyw.icoremail.net (zg8tmty1ljiyny4xntuumtyw.icoremail.net [165.227.155.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A88834D3B9;
	Mon,  3 Nov 2025 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.155.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762136185; cv=none; b=LM4hpH+GuRU3Jx3o7qk5aszxAKkroh+ye3yu8PpQUrcmZ3+t+nLwDLDARkNO1O1F57Eq70oAmb1Q5mj+YJU9bQd7MJ1G5PMc0XWFGghIDhfBAQ7JHx6+aPMkPmvfKQqnY4rj8VwG7m/3QHEa2DyyXYtPSN04fyyS9sZOHTRRWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762136185; c=relaxed/simple;
	bh=jhAc50RPWxxad6/xGj3VVJBYsKiD2laQODvlx5EXyfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cCNsuzti4tKpOPEs6+lCH2OcpO9nPaTwJUcjpb0AwVavzDWtRarrEmP0ULzvglGz2KqYej3fcZvcrUIGYujeElbxajTaqO71ex6Zpr0WHvrKAuDL+03iEVqv+9jwv/6+KbLPvHWkz6RNzu1KiWUbW+265r/KuMIeNw21XUzrIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ZOwvOI38; arc=none smtp.client-ip=165.227.155.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=kN1As4jsX+zsXSOddNqaULOIpOsS+8lXlV
	TZIXB8bjA=; b=ZOwvOI38FsFiF+PovGogtnzyizPq31voKWv0kufCUZItrutEwd
	hWDw8Gs5RttFH2ILTIPSjM+JRnFtUzKQXgAeMWDiy16sGpepGYJvbtTFYWZkVlEh
	tzq9ZyJw5CpMGlsDihQTYseHVHPT2K3TUD5VLSnKMhroVLNp6cq6/vXg4=
Received: from estar-Super-Server.. (unknown [103.233.162.254])
	by web4 (Coremail) with SMTP id ywQGZQDH9aNdEAhp5M6tBQ--.26864S2;
	Mon, 03 Nov 2025 10:16:10 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org,
	zhaoyz24@mails.tsinghua.edu.cn
Subject: Re: Re: [PATCH v3 RESEND] net/dccp: validate Reset/Close/CloseReq in DCCP_REQUESTING
Date: Mon,  3 Nov 2025 10:15:57 +0800
Message-Id: <20251103021557.4020515-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251102155428.4186946a@kernel.org>
References: <20251102155428.4186946a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQDH9aNdEAhp5M6tBQ--.26864S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY-7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z2
	80aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY
	62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7V
	C2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0
	x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
	4UYxBIdaVFxhVjvjDU0xZFpf9x0JUDgA7UUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgEPAWkHO2TRPgAAsT

Dear Jakub,

Following your instruction, we read the documentation at https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html.
We found that the stable documentation normally requires an upstream commit before inclusion in stable, but here an upstream commit 
cannot exist because the subsystem was removed. Could you please confirm that this can proceed as a stable-only fix for the affected LTS branches?

Thanks for your guidance on the correct path here.

Yours Sincerely,
Yizhou Zhao


