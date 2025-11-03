Return-Path: <stable+bounces-192129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87667C29C33
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 02:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC71F34754E
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 01:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD3126E714;
	Mon,  3 Nov 2025 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="MNX7RBhe"
X-Original-To: stable@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90C626E71B;
	Mon,  3 Nov 2025 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762132351; cv=none; b=i6V0SwBgrdMHmEDeIPSI+oHfH6uVBwtL080tY0ws5CFoxV77Gp1XIgtRCYu8X9QPDgmpUnRJ7gFE6oZBuc6PlBwNlw5h9VUdlEtA7JqZjI5BN7vkArDBUb58V1XrHLJAun4NkDkaJ1zpNZRm16g8SOLxhJ/5FvP5LlkFW3ReJZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762132351; c=relaxed/simple;
	bh=PCidbrzWqqhfhon3Vw7x7EQqRlUNn1VSF2QjfmxrmHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7t6yxm0HVOLnere++ZzNEKTMJpXh53Us8kYt1KqbEJAaZPGxVkCP4eSaJv02/1N6bxuA7yI1Pralh5KOC0lRbDs7nRNji3+Mc1/vet8uSPWcvwZw4MdIXBjg0ypYt89f6ihPapP72w4TwVSCzTHyMG4Zt9a+GLKgPLkuGciST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=MNX7RBhe; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=PCidbrzWqqhfhon3Vw7x7EQqRlUNn1VSF2
	QjfmxrmHA=; b=MNX7RBhenyFPkD6CSp6ylnvF+29r1rZTip2/ueOlB/wvyow+bj
	6jm6swoUj2kJnZ3MkT0j7ob4+gKxF4pBe3Xn4aqwzRr9wuusm1ryJz/ygIQjFYQ1
	8o1+f0fhmWPYL/ArMkyFdyjXNbXgqILzsTHN3gF0Vu25M6kFH/3V3+vcw=
Received: from estar-Super-Server.. (unknown [103.233.162.254])
	by web2 (Coremail) with SMTP id yQQGZQCXfwpdAQhpsL+6BA--.5887S2;
	Mon, 03 Nov 2025 09:12:19 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org,
	zhaoyz24@mails.tsinghua.edu.cn
Subject: Re: Re: [PATCH v3 RESEND] net/dccp: validate Reset/Close/CloseReq in DCCP_REQUESTING
Date: Mon,  3 Nov 2025 09:11:58 +0800
Message-Id: <20251103011158.4016792-1-zhaoyz24@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yQQGZQCXfwpdAQhpsL+6BA--.5887S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYT7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	F7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
	W8JbIYCTnIWIevJa73UjIFyTuYvjfU5eHqDUUUU
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQEPAWkHO3eM9QABsU

Dear Jakub,

Thank you for your suggestion. We will
reorganize our patch and send it to stable
only later.

Yours Sincerely,
Yizhou Zhao


