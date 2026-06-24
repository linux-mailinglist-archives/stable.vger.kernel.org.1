Return-Path: <stable+bounces-268046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VoyZAeMwO2rGSQgAu9opvQ
	(envelope-from <stable+bounces-268046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 03:20:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 595846BAC5C
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 03:20:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none ("invalid DKIM record") header.d=stu.xidian.edu.cn header.s=dkim header.b=iqW5JDek;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268046-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268046-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=xidian.edu.cn (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAAE7304DAF9
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDAF242D72;
	Wed, 24 Jun 2026 01:20:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ABC19995E;
	Wed, 24 Jun 2026 01:20:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782264026; cv=none; b=GS5Iyw6D+HZ/CKRVBnflnKEDu3zO+3L09+keUDXo5WXLy24SjkcmMHYiaztSu3Lm6k728EkZbOGATSO81ywD05m9RkCSw6u0yeioGjNSon18Cx8n8Y9vbbQIKABuxJtYQSEsyc4wsNInJI+ZV1cy97dvAdjFHyyXDJKGB80CO24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782264026; c=relaxed/simple;
	bh=LRhhQxlv7tDwHgMYsYEz+Cp27davY0GRfN0Qh1DiFjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rx+AGUTWU696uOQtyB4fjx0sm78kfL+0X+NZasYrhjuCL1FakvbDWEJiVyEOx3lFrrXRahN5VG+xSa+Z32JDXA5V1jNQzqgm+AhEsvQwAuNXYqQNN4urG6GwAEJtXZlys9iOF0Q/ggLMMK00p6dsulOPdqbsPxIk9M1WdF1dKD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=iqW5JDek reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=RhVCMiN2A
	jWP4GgT4xDsh2vnJCHKlRf8JX+7XyIr3qs=; b=iqW5JDekV0Rr6xayW1rPl0IPM
	4UhfwEYxIBt5pMhPTz4POibxsHWBuzXVNRGVxaKoMGReoOXOGaBFmByQKZxIQWfp
	Odiro53WUEwbpA7QRiUq3URiLzTV+SsouMSxfCpnpmQ7i8XID2lWBdAPnyFjlyCc
	MLgIkyCbciiNEAzk/Q=
Received: from [10.196.180.86] (unknown [113.200.174.80])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkB2G7fKMDtqhoAXAw--.55906S3;
	Wed, 24 Jun 2026 09:20:11 +0800 (CST)
Message-ID: <ca6fbfb1-1e08-4b4f-b823-8312327d5b38@stu.xidian.edu.cn>
Date: Wed, 24 Jun 2026 09:20:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: i801: fix hardware state machine corruption in
 error path
To: Andi Shyti <andi.shyti@kernel.org>, w15303746062@163.com
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260512093534.348655-1-w15303746062@163.com>
 <ajqtEIAX_D5z_UW5@zenone.zhora.eu>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <ajqtEIAX_D5z_UW5@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BrQMCkB2G7fKMDtqhoAXAw--.55906S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYB7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
	6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr
	0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcVAKI48JMxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14
	v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2eOJUUUUU
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUOEWo6o2ZU4QAAs7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[xidian.edu.cn : SPF not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,163.com];
	FORGED_RECIPIENTS(0.00)[m:andi.shyti@kernel.org,m:w15303746062@163.com,m:jdelvare@suse.com,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[25181214217@stu.xidian.edu.cn,stable@vger.kernel.org];
	R_DKIM_PERMFAIL(0.00)[stu.xidian.edu.cn:s=dkim];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268046-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25181214217@stu.xidian.edu.cn,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[stu.xidian.edu.cn:~];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 595846BAC5C

Hi Andi,

>> Fixes: 1f760b87e54c ("i2c: i801: Call i801_check_pre() from i801_access()")
>> Cc: stable@vger.kernel.org # v6.3+
> Please, next time don't leave a blank space in the tag section.
I apologize for that; it was an oversight on my part. I'll be more 
careful in future submissions.
> The patch looks correct to me, although I'd have liked an ack
> from Jean.
>
> I merged it to i2c/i2c-fixes.

I understand.

If Jean has any concerns, I'm happy to provide a follow-up fix if needed.

I'll also keep an eye on the thread in case he comments.


Best regards,
Mingyu Wang


