Return-Path: <stable+bounces-244153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULqfBdft+WlqFQMAu9opvQ
	(envelope-from <stable+bounces-244153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:17:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EDF4CE4AB
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4326A3061ADC
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62E038DD3;
	Tue,  5 May 2026 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4HQqU3a"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F52FE579
	for <stable@vger.kernel.org>; Tue,  5 May 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986990; cv=none; b=rnseqzos9b63PrckUbxAP9M6MQidMEGs69XaRLuWmJEZKizTF6OcWcVqXn/R7VOR9+nZWQ4d1s7sRdl/XCbXdcTIMEHcr0hpnmgbG/fOm4CtdeUVJgfMzDv6H+0BGjs0JWi7tQCTcEHZEPqSSHplQPpv2ltZbc0cgfZiQkXmle8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986990; c=relaxed/simple;
	bh=HHBBf63C55MZMSnlcu9etJXthxILRS+gIzX/cWZC9t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdPj/6TWoVbzU/RbZWLfiXsJze/HYX51ikjJwibvlHZgLMwidXa6M1r0KqSBv8dhOuikqwABDlw4W1o+YqqGfheht/CeY+J/s+YemH0DrdKk+ogXHM66TL0hbaTixFxcDQjiLrKZdMV74veF2tH8N0fgMSzW5IfjHKMPBU9jiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4HQqU3a; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so12435411eec.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777986988; x=1778591788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9c4M1Sxe8XfnwUoevaoL/2OztS3a3daovY1Nhqp4yXk=;
        b=T4HQqU3aeu9rTntyow+TeZcIgtfHktNYfdyfTuaIbUskk3Fg7tYNp5qgs+b9qUPrrY
         hVmK1GDRXbHmdFo2DQsS4prpcRpSM+lrJnzkOgvuqP5JXGl0VA6/+Z3N1BDaZH8iRqM8
         y+k+0uItveVpIVgmAYzPDgUsCPerJG54yahYquso9gG9YPONmJ8cA3g/ocRK1f0EZTut
         Mjhk9kQ64lnrL+tavqwpLnFiUkF8N842cM9FAeEqNVL+YtPdbmNfs5sWt8fN3Qc7n+dk
         koMD/i0EAQY7PmZUzX5wrf10uKeP4elrmu1fb56ML6c7iMPk7fGAO252w2MYYZ2PCX3+
         hkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986988; x=1778591788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9c4M1Sxe8XfnwUoevaoL/2OztS3a3daovY1Nhqp4yXk=;
        b=jkPP3bCUMCP4oHQHe3kG3u103uaMrHGCVy9dLHceKJR1OQmOC9r6EaJQ5nKhpWoKUp
         x/Ad0qsCqK+W4KJ/+EVDpjI2mV3a2o2u7RMINFq1UNdtPhVXKtal+cqfTDI9cIx4jwcZ
         PLm9s7fq4k4qDkGVVJVIDIjkg0emJYqUWE8YaYD/DgEIgfQte0uD7Txlaq1zN0AvREAO
         5jgA9MRacVmdSLWimBrXGGsuwdGqH/DSV+sd+dl84hdaI7EdzMz/ZYgA3Gp1YagDTjce
         uRaNXFj+2TUKjysSQs8Ro1pMBFKeoCpWnxkMmiNpuIpcszQRVqF8T6oXv59a01PzzaXK
         aKiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/5UyXMrtZP9tf6VKmBudi9VLCoEox16QVyyG8QYASYkPLxRPdVbJp7gfHzab/mu0RGBTITLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUxNSTQrLpTCfdeUQvUhvfa2a2LspLv9gNXk9qGMwwrlY4LlZQ
	anRQxTnZKGhLV8Ymw0MUYlX8LaZJQCle434wcyP3Tnpd6iA+oMQnz3jV
X-Gm-Gg: AeBDiev5j3OcxVxXiJO3ApLcc/JUj2Gq5jyuk88HRy5urO6TRB9ec/aqkaESkahjChe
	5v0cnPkDGBRCkaizcTlRrVonmeIge5IQoa0QXOhBTqmKpOrdeMzt5sUkpfcZz/BeMwLpFqYoEF7
	4q5HB2Q9ghTsFCHe2Y8NkTT5bn1YXYm/mSbME8x8Fk2AMlCPCqcg34+7zGNglVXPYTuhZaLdHj5
	Ez63kuOg/Yiy2c3jWr+VQJRG7m60XSjMhe4GzR5cgtNYY+16d3RstZlWLjbywvMShjIsFfLhZTx
	UozxKSiEnH3KevZqOALxkzB4OldiTuUN+hPpGKA8V+IPDMtmxDkf7ZlEJOzR3pGUuouvmyXWvcB
	cSqCw1dsUNiFpi4eehy2tJ/v/P1vLgYYKu69dVZ7X4CSLhYnlyiYXy6C5X29Knys5SYsN/htxFw
	OhuS306xfUQYwpvjbpfLHif+OUUoQA1qVCUqniRpsA7s4tMeRtcf7ZF7BKTw==
X-Received: by 2002:a05:7300:e68b:b0:2e6:e868:4f38 with SMTP id 5a478bee46e88-2efb7ad902emr7357996eec.3.1777986988349;
        Tue, 05 May 2026 06:16:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee393578f1sm20977783eec.13.2026.05.05.06.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:16:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 May 2026 06:16:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-watchdog@vger.kernel.org, stable@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: Re: [PATCH] watchdog: s32g_wdt: remove incorrect options in
 watchdog_info struct
Message-ID: <e1950f20-3b1f-4989-a360-d330949757f5@roeck-us.net>
References: <20260505024409.60301-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505024409.60301-1-enelsonmoore@gmail.com>
X-Rspamd-Queue-Id: A3EDF4CE4AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244153-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, May 04, 2026 at 07:44:09PM -0700, Ethan Nelson-Moore wrote:
> The s32g_wdt driver uses two incorrect constants in the options field
> of its watchdog_info struct. This bit mask should contain WDIOF_*
> constants, but the driver uses two WDIOC_* ioctl constants (in addition
> to correct WDIOF_* constants). This causes many incorrect bits to be
> set in the bit mask. The functionality indicated by these ioctl
> constants is supported by all drivers using the watchdog framework, so
> this patch simply removes them.
> 
> Fixes: bd3f54ec559b ("watchdog: Add the Watchdog Timer for the NXP S32 platform")
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Applied to my watchdog branch.

Thanks,
Guenter

