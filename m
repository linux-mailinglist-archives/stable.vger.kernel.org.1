Return-Path: <stable+bounces-211359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA10Gb8kc2nCsgAAu9opvQ
	(envelope-from <stable+bounces-211359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 08:35:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF3371C78
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 08:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A45F43014C14
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B486307492;
	Fri, 23 Jan 2026 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdnFHa6a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DF62EA48F;
	Fri, 23 Jan 2026 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153722; cv=none; b=PjospcIG/KHwyy+WgXu8gagdlS3oTE3N/9GutL373zaMkj4fVA+FfjMZEt2rHrTnRgr7SZe6ZF5gWFOgDEfnk38Aq1NbU3I+xklJ281uDz11JV1vrNWC3H4s4R2yxlsxR4RgDFBxhdxUpx3jA/RM971KNVWMNHpdt//DDm9+g7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153722; c=relaxed/simple;
	bh=GKOeyS1K3rfOAmVVi3P0BY1kZ4FOXbUQ5mLzkw9Qnhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dixQsRn86yyomBJ8GCmNL92kdY5JAsGBnBzvollRonmlx9p/aE3M2j5iEoMBqQrVgFYGT8//pLXKWikHfK10I5HS2SG3J9r/E3VaHHoEvIlfGQRXtnuySwmTQnS/aESrpE564aDJ/8gVZe7G7CnlHLVPASAn3wUZ4jjVJBJ8fsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdnFHa6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913A9C4CEF1;
	Fri, 23 Jan 2026 07:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769153721;
	bh=GKOeyS1K3rfOAmVVi3P0BY1kZ4FOXbUQ5mLzkw9Qnhk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cdnFHa6acOhen3sG8YsgihUo67aSjrJ11MNnbM4wzKfrCG+DvmnzzDj8XAXm9u0/x
	 o+ODFNva8MQpI61LQnbSq2C1fqAb0mx8DG7TUIr51+aO2ohjrUz6ocKnPNMaEGKiSA
	 y7tgcbAchwN/odopNH1/ImC948GoArXGwnrD9NNnOjqKEqio//Hd9BU3jFTCzb8U3j
	 cso9KRc4X/uYBEqmf4lTSysxgoRgJJCwGYBRM1SLhJhhpv3MoZ/1rikCpQHq6XxHld
	 ZDqMqgseZExfl4fRdajbneQHBLSLXW7w7XfW96yMhrZXeyu17xJBk6jo89kxMOkkDt
	 Agh1MH4qECfiA==
Message-ID: <9a5867b0-a271-43b9-9b02-743185ee83c2@kernel.org>
Date: Fri, 23 Jan 2026 08:35:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: Fix not set tty->port race condition
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260123072139.53293-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260123072139.53293-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211359-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jirislaby@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: CAF3371C78
X-Rspamd-Action: no action

On 23. 01. 26, 8:21, Krzysztof Kozlowski wrote:
> Revert commit bfc467db60b7 ("serial: remove redundant
> tty_port_link_device()") because the tty_port_link_device() is not
> redundant: the tty->port has to be confured before we call
> uart_configure_port(), otherwise user-space can open console without TTY
> linked to the driver.
> 
> This tty_port_link_device() was added explicitly to avoid this exact
> issue in commit fb2b90014d78 ("tty: link tty and port before configuring
> it as console"), so offending commit basically reverted the fix saying
> it is redundant without addressing the actual race condition presented
> there.
> 
> Reproducible always as tty->port warning on Qualcomm SoC with most of
> devices disabled, so with very fast boot, and one serial device being
> the console:
> 
>    printk: legacy console [ttyMSM0] enabled
>    printk: legacy console [ttyMSM0] enabled
>    printk: legacy bootconsole [qcom_geni0] disabled
>    printk: legacy bootconsole [qcom_geni0] disabled
>    ------------[ cut here ]------------
>    tty_init_dev: ttyMSM driver does not set tty->port. This would crash the kernel. Fix the driver!
>    WARNING: drivers/tty/tty_io.c:1414 at tty_init_dev.part.0+0x228/0x25c, CPU#2: systemd/1
>    Modules linked in: socinfo tcsrcc_eliza gcc_eliza sm3_ce fuse ipv6
>    CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G S                  6.19.0-rc4-next-20260108-00024-g2202f4d30aa8 #73 PREEMPT
>    Tainted: [S]=CPU_OUT_OF_SPEC
>    Hardware name: Qualcomm Technologies, Inc. Eliza (DT)
>    ...
>    tty_init_dev.part.0 (drivers/tty/tty_io.c:1414 (discriminator 11)) (P)
>    tty_open (arch/arm64/include/asm/atomic_ll_sc.h:95 (discriminator 3) drivers/tty/tty_io.c:2073 (discriminator 3) drivers/tty/tty_io.c:2120 (discriminator 3))
>    chrdev_open (fs/char_dev.c:411)
>    do_dentry_open (fs/open.c:962)
>    vfs_open (fs/open.c:1094)
>    do_open (fs/namei.c:4634)
>    path_openat (fs/namei.c:4793)
>    do_filp_open (fs/namei.c:4820)
>    do_sys_openat2 (fs/open.c:1391 (discriminator 3))
>    ...
>    Starting Network Name Resolution...
> 
> Apparently the flow with this small Yocto-based ramdisk user-space is:
> 
> driver (qcom_geni_serial.c):                  user-space:
> ============================                  ===========
> qcom_geni_serial_probe()
>   uart_add_one_port()
>    serial_core_register_port()
>     serial_core_add_one_port()
>      uart_configure_port()
>       register_console()
>      |
>      |                                         open console
>      |                                          ...
>      |                                          tty_init_dev()
>      |                                           driver->ports[idx] is NULL
>      |
>      tty_port_register_device_attr_serdev()
>       tty_port_link_device() <- set driver->ports[idx]
> 
> Fixes: bfc467db60b7 ("serial: remove redundant tty_port_link_device()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thanks for the update.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs

