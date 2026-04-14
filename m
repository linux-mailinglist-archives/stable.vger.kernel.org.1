Return-Path: <stable+bounces-237904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBw1MOdb3mlACQAAu9opvQ
	(envelope-from <stable+bounces-237904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:23:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D713FBB59
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8689F30235A8
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFF93E6396;
	Tue, 14 Apr 2026 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uD2Obgv0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WTQEUfVl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uD2Obgv0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WTQEUfVl"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12942AA9
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180168; cv=none; b=Bg+Xe9mPBUy/xzrC8/5tcDIq/lSnQpI9n9KW9WhLopJAwNDYx8KELmtF7Bu2dAAKLF90ZOvEGb9YROdfG5Cn/jV0ZMnGWPvDkbmQ1lSK0vnLhiFJakbr5wZCcz7Qrxx+O3Gnj3bTqnJkbpMJEHF7JjA2OYAFzhoRjHbCpUeFx1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180168; c=relaxed/simple;
	bh=0kQ5uJtoBuLN0fIMVLFqIbC3QFm6h/7AJ+bjztIpBC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eip7ntV1+m2aHEz+9h7I4fvnLgNG3whjxdustaDRh8DquxJly5Y/RrKz7NhUeQe7mBo5obUNzpECxLJsW7kn+uUYg25y97l169JeULNs70jIFPGoi+alfABWMvKpr0Eyi80BMlMMyPpuzPjdRf1IvyZ0xu+kBBf18VE2gpTYXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uD2Obgv0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WTQEUfVl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uD2Obgv0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WTQEUfVl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E3BA5BD20;
	Tue, 14 Apr 2026 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776180163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6rGnheeTDpxVR2X+a8HXYFuLJSPXwJxQPLPnAygMiQ=;
	b=uD2Obgv0K1m2PUgWfhyP0GAJdXS+SY5SBuM8+qncRRF1J+evDeNzNvu1NTIovVFFvafdZf
	7zZYCxU0gsoZx7yA2fItB556xYdAorRqGsl+cclmPZeryERDh6NVG9FdQ5z8wA8igRP3TP
	QUWGWDMY1/qmJKDTWlMLabd45CYGNmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776180163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6rGnheeTDpxVR2X+a8HXYFuLJSPXwJxQPLPnAygMiQ=;
	b=WTQEUfVluTqwcr4wXgIAvsU1Z0kJ3UElf9KiaMH7rfkSheNKVVuAH5DbLA3CmsmXJWUlzn
	WZRa/Jhx8VllK+Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uD2Obgv0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WTQEUfVl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776180163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6rGnheeTDpxVR2X+a8HXYFuLJSPXwJxQPLPnAygMiQ=;
	b=uD2Obgv0K1m2PUgWfhyP0GAJdXS+SY5SBuM8+qncRRF1J+evDeNzNvu1NTIovVFFvafdZf
	7zZYCxU0gsoZx7yA2fItB556xYdAorRqGsl+cclmPZeryERDh6NVG9FdQ5z8wA8igRP3TP
	QUWGWDMY1/qmJKDTWlMLabd45CYGNmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776180163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6rGnheeTDpxVR2X+a8HXYFuLJSPXwJxQPLPnAygMiQ=;
	b=WTQEUfVluTqwcr4wXgIAvsU1Z0kJ3UElf9KiaMH7rfkSheNKVVuAH5DbLA3CmsmXJWUlzn
	WZRa/Jhx8VllK+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 263444B4F1;
	Tue, 14 Apr 2026 15:22:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1ldqB8Nb3mnrMwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 14 Apr 2026 15:22:43 +0000
Date: Tue, 14 Apr 2026 17:22:39 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-i2c@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
 stable@vger.kernel.org
Subject: Re: [PATCH] i2c: stub: Reject I2C block transfers exceeding
 I2C_SMBUS_BLOCK_MAX
Message-ID: <20260414172239.7e98a0ae@endymion>
In-Reply-To: <20260329164126.820797-2-bestswngs@gmail.com>
References: <20260329164126.820797-2-bestswngs@gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237904-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jdelvare@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: C2D713FBB59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Weiming,

On Mon, 30 Mar 2026 00:41:27 +0800, Weiming Shi wrote:
> The I2C_SMBUS_I2C_BLOCK_DATA case in stub_xfer() uses data->block[0]
> as the transfer length. The existing check only clamps it to avoid
> overrunning the chip->words[256] register array, but does not validate
> it against I2C_SMBUS_BLOCK_MAX (32), which is the limit of the union
> i2c_smbus_data.block buffer (34 bytes total). The driver is a
> development/test tool (CONFIG_I2C_STUB=m, not built by default)
> that must be loaded with a chip_addr= parameter.
> 
> A local user with access to /dev/i2c-* can issue an I2C_SMBUS ioctl
> with I2C_SMBUS_I2C_BLOCK_DATA and data->block[0] > 32, causing
> stub_xfer() to read or write past the end of the union
> i2c_smbus_data.block buffer:
> 
>  BUG: KASAN: stack-out-of-bounds in stub_xfer (drivers/i2c/i2c-stub.c:223)
>  Read of size 1 at addr ffff88800abcfd92 by task exploit/81
>  Call Trace:
>   <TASK>
>   stub_xfer (drivers/i2c/i2c-stub.c:223)
>   __i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:593)
>   i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:536)
>   i2cdev_ioctl_smbus (drivers/i2c/i2c-dev.c:391)
>   i2cdev_ioctl (drivers/i2c/i2c-dev.c:478)
>   __x64_sys_ioctl (fs/ioctl.c:583)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>   </TASK>
> 
> The bug exists because i2c-stub implements .smbus_xfer directly,
> bypassing the I2C_SMBUS_BLOCK_MAX validation in
> i2c_smbus_xfer_emulated(). The I2C_SMBUS_BLOCK_DATA case in the same
> function correctly validates against I2C_SMBUS_BLOCK_MAX, but the
> I2C_SMBUS_I2C_BLOCK_DATA case does not.

Thank you for the excellent analysis and detailed description. I agree
with everything you wrote above.

> Fix by rejecting oversized transfers with -EINVAL when
> data->block[0] exceeds I2C_SMBUS_BLOCK_MAX, consistent with both
> the I2C_SMBUS_BLOCK_DATA case in the same function and the
> I2C_SMBUS_I2C_BLOCK_DATA validation in i2c_smbus_xfer_emulated().

Would it make sense to also reject len == 0? That's what the i2c-stub
driver does in the I2C_SMBUS_BLOCK_DATA case, so it would seem
consistent to do the same for the I2C_SMBUS_I2C_BLOCK_DATA case.

> 
> Fixes: 4710317891e4 ("i2c-stub: Implement I2C block support")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>

If there any public link to that report? If so, it should be mentioned
here with a Closes: tag.

> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  drivers/i2c/i2c-stub.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
> index fbb0db41b10e1..349ef9fb2fdbc 100644
> --- a/drivers/i2c/i2c-stub.c
> +++ b/drivers/i2c/i2c-stub.c
> @@ -214,6 +214,10 @@ static s32 stub_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
>  		 * We ignore banks here, because banked chips don't use I2C
>  		 * block transfers
>  		 */
> +		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
> +			ret = -EINVAL;
> +			break;
> +		}
>  		if (data->block[0] > 256 - command)	/* Avoid overrun */
>  			data->block[0] = 256 - command;
>  		len = data->block[0];

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

