Return-Path: <stable+bounces-192347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A10CC30639
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 10:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BACD4E8B30
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4784F2D0631;
	Tue,  4 Nov 2025 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="DZmTawtV"
X-Original-To: stable@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711202EC0A5
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250315; cv=none; b=JINLWqUIfKBAWGbtXDQEqr7KpVaC04ftXGFECvW7ooW1hYyKPHNEHSK95SeYE+SWLs6iEmE5Rh16amdYLWBsQINAV8VHtk+sOe8acWhtamsEYshZU0iuuLedatuXo9nkVxWy9CTtvOjpVDiiu5InuBQlstt39Zlz5hLOH4spwGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250315; c=relaxed/simple;
	bh=zjCswPbTYDHxBsB3/3V5FAaibh8eduTjd4CPKzCtmi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2dwBXKp/oGtu16B+SApGTMZ6EP0YehVr5N5yipjF3i/Nj2mslriEHOIk/V1n9AUaMyWUwWQm6f3w0z5eUNTweeV+tlKBg+prLcV3ZE8uKKQEPx9iiZ9UXay9eNztNATBY1qGL/RhXhsZjFS3XUAyx3yVm1AgCDYNuf5Xuy67p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=DZmTawtV; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=R1zdvYYx4XyEcsCp77SCPRNfbxLuD06SQS
	bYDlkXINA=; b=DZmTawtVhQceHW3rAZysXvcVJtAKxky4xbaCN9kXZtmIw+oQqR
	VmVUq9Y6sQdMVSadNNOk7cV8mq4DITI5QhTvv5kadt7kR7a4mtafdI36ebc9KpjD
	OwNPredEozXbtwUfMhRoWg5tB9klmChzimNvOzOYhjtHcUywUy7a40li8=
Received: from estar-Super-Server.. (unknown [103.233.162.254])
	by web2 (Coremail) with SMTP id yQQGZQAXvi4uzglpxXYGAA--.16713S2;
	Tue, 04 Nov 2025 17:58:20 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	zhaoyz24@mails.tsinghua.edu.cn,
	kuba@kernel.org
Subject: Re: Re: [PATCH] dccp: validate incoming Reset/Close/CloseReq in DCCP_REQUESTING
Date: Tue,  4 Nov 2025 17:58:08 +0800
Message-Id: <20251104095808.4086561-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025110351-comfy-untwist-fabb@gregkh>
References: <2025110351-comfy-untwist-fabb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQAXvi4uzglpxXYGAA--.16713S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFWkAF1fury7tFW5AF15twb_yoW3twb_K3
	4jgr97A3409FsF9a1xKFZIqrWDtrs2ya4rC3y5Kr47twn5AF1xZan3GrW3Zr1rKFyvyFyU
	XF1kuanruw4jgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JU4mhwUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQEPAWkHO3eM9QAIsd

Dear Greg,

Thank you for the guidance.

I'm sorry that I haven't explicitly stated that this should be a
stable-only fix. DCCP was removed upstream in v6.16, so the issue
cannot be fixed in mainline. I missed including that context in the
original submission.

Jakub confirmed that this fix may proceed as a stable-only patch for
branches which still contain DCCP. [1]

Do you prefer that I submit a v2 explicitly marked as a stable-only 
fix? Just want to ensure I follow the expected process.

BTW: I could not find specific guidance in the stable-kernel rules 
on how a stable-only patch (for upstream-removed code) should be 
formatted. Could you advise a sample expected structure?

Thank you for your time and review.

Your Sincerely,
Yizhou Zhao

[1] https://lore.kernel.org/netdev/20251103154439.58c3664c@kernel.org/


