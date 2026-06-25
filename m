Return-Path: <stable+bounces-268590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pdvCC6RHPWrk0ggAu9opvQ
	(envelope-from <stable+bounces-268590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:22:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 821CB6C704E
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:22:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none ("invalid DKIM record") header.d=stu.xidian.edu.cn header.s=dkim header.b=NwZRwZFb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268590-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268590-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=xidian.edu.cn (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 918913076F0F
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8233E8337;
	Thu, 25 Jun 2026 15:18:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5715A367B62;
	Thu, 25 Jun 2026 15:18:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400718; cv=none; b=thXsFHxNgXjzbfPXbFthuDxIl9caByQ7Emc/1nh8BhrFRNyoTtrEdPPrXCOqAwNARQ1hlooyLW/+MMHpfXT9+IKhlnS3kmPMid446rRCfg+lEaORm+QIRkSG2TV18AYm0oO1cWCtkCncMj+fuqV+WWaLjNVW1MyHqtfNfglfS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400718; c=relaxed/simple;
	bh=gF7cN1XBfU+vYIAiMKMGthjfqnRBxkJi+XdTR3JVbbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4qnFsPVQctL8k3Ay7xEk2SXKfmn1Gw3V9ZQrVuBejMcR7hvC2Ci3EDvuL1h/T2f09MPi8ne4TBs9keWf94i5KrLb9bNhL9K+NDKxmKRGWe+QWp1/O+KlKRmUh7KKhC7cS00o2YwGVPGlOGFhEnhaV0d4FnjqUU1XymN3XJwZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=NwZRwZFb reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=4kyyfjN9B
	zKx+wWFPMXdh5wL3oVfa81GTY/BlCtYCN4=; b=NwZRwZFbveEg2cIwkElfUH350
	CqSGnoMlU+hn0xl4+lqON55BJftz9GkDhDdQtEj2o8vFvxldOCJTbeI1QSiEfS07
	A576vR1q7xHhS4j6km8gqyEYgc1E9tBTWWotcLyhMwla9EUucx3uOaouFa7xKeEc
	dpV3dDBnssKI6vPKvM=
Received: from [10.196.180.86] (unknown [113.200.174.80])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkDGDzW5Rj1qp6gAAA--.2760S3;
	Thu, 25 Jun 2026 23:18:19 +0800 (CST)
Message-ID: <d8e82639-c112-41bd-8ab3-f3f5fa9f80d6@stu.xidian.edu.cn>
Date: Thu, 25 Jun 2026 23:18:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: fbcon: fix out-of-bounds read in err_out of
 fbcon_do_set_font()
To: Thomas Zimmermann <tzimmermann@suse.de>, w15303746062@163.com,
 deller@gmx.de, simona@ffwll.ch
Cc: syoshida@redhat.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260624083316.389677-1-w15303746062@163.com>
 <7dd87e55-5170-4317-8c9e-38a7868f68fc@suse.de>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <7dd87e55-5170-4317-8c9e-38a7868f68fc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BLQMCkDGDzW5Rj1qp6gAAA--.2760S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYd7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
	6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC
	4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcVAKI48JMxkIecxEwVAFwVW5WwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262
	kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jwPEfUUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUPEWo9P0QD-wABsI
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[xidian.edu.cn : SPF not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tzimmermann@suse.de,m:w15303746062@163.com,m:deller@gmx.de,m:simona@ffwll.ch,m:syoshida@redhat.com,m:dri-devel@lists.freedesktop.org,m:linux-fbdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[25181214217@stu.xidian.edu.cn,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268590-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,163.com,gmx.de,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_PERMFAIL(0.00)[stu.xidian.edu.cn:s=dkim];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[stu.xidian.edu.cn:~];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25181214217@stu.xidian.edu.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 821CB6C704E

Hi Thomas,


>
> The email in your S-o-b tag differs from the one in the mail's From: 
> line. I think this is not accepted in the kernel. Can you please 
> resubmit with the email addresses synchronized.
>
>

Thank you very much for the review and the Reviewed-by tag!

The email mismatch was due to my university's SMTP server restrictions, 
which forced me to use my personal 163 email to route the patch. I 
apologize for the confusion.

I will synchronize my git authorship and Signed-off-by tags, and send a 
v2 patch shortly with your Reviewed-by tag included.

Best regards,
Mingyu


