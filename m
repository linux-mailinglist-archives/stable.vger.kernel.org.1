Return-Path: <stable+bounces-242212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJR3BrjP82nq7AEAu9opvQ
	(envelope-from <stable+bounces-242212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 23:55:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B384A4A867C
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 23:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 206A13006441
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 21:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B6739A078;
	Thu, 30 Apr 2026 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8awkKP+"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE581377EC6
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777586101; cv=none; b=gtZLa6Tkg4hzt5otHrJnfbyIygJZlxFC3UU5DIFkO7S0OTuNIUCaCqUNyN1LRMbmlRZb0FCV3lON2omXRoUzPKtXsHjekTuf2EF0BdyQZw58OLZkFqxoSFrM2QAguuAHPbTms17DdbbHkOEQYzxbLt7pSVqX2OATdRz3H1Krl54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777586101; c=relaxed/simple;
	bh=OfOzv1CwKJM9L7Z3x9sYHunCD19yBvZ9TOBl02q92j0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8u2/Ck8eXFlLDNbQGJrhvLpwaGPcdR/vtQncqIdU6/XjRFcz7xabi5fukSJnez+AL969tiaQbGvbhjn7MTdcezv6DMxGgTeSQ4rD010ooUFdTXI/g2nagayF/+DHraYOV6Qw79z0n2gjIoFad7vp3CEMXbenr9wqPEXlgk2rMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8awkKP+; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a748d5ece4so1539107e87.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777586098; x=1778190898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htONy2JrV9dOzOKD0squdGdFWilpbZGrAvV2FXjkQoA=;
        b=p8awkKP+xeBPAoUs2/VTBqq0clGHIe1/2oWxk0aGnPcmldlM7HRw4bpK8+dhL/NV1S
         thOa+/3zBgeuirFZIq7Uh1gR0mieOj0pLALwtJG2H15mm0KKdDgyvaCJwsavOHMzhnln
         zNTHtVXGjhAgaFm1kTNDwbKf+Bls7FPvECHNvNq8Exv6aP2lqgrLE5LEMrCgh5KCwX9G
         +8v89JwzdZZt0NMd0jfAt2BwTOWyqjDRhyMP59qq413D2TIajCYlGHNuTBGp07kuRSnM
         Ytnse9jsk9mQf34i+0M9xf7kS5rsDPIm6GsbZuSAwiyOdqfdDCGdDleWiupAy5EBx++W
         4Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777586098; x=1778190898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htONy2JrV9dOzOKD0squdGdFWilpbZGrAvV2FXjkQoA=;
        b=eEG0ZSDzd74fUurMOqK17GGCIUHCFnfX5YWud7HBu4FumDOxpYsGO+SA4Truva8Ma/
         F9+5Z1yvzHpPAfYWUN9ACaGQ4sOPmPaGvKriwAvpqgybgVnIgnt/YfLa0nevvXW0Bi09
         GjchcyQBbJNW9grDezMakfZ1ZEz60uVJ4LpcJIVBTYoLDQUvZm8ofxeriHLZDySjsETZ
         p0sK4h/8utm4JK+FStRoeK8zvR5lC8xQjIdZ/p77/aeCoZHDkky5fdSCz1TnImSOlnFP
         JjAzbZsgCi+4O6IGIBFi7FTALNFkBXH5vqbHXvVXTG243RhQxKSJpp1a46Uvl7+2kBQD
         mn3A==
X-Forwarded-Encrypted: i=1; AFNElJ+thCxlWXLNmhioWJOh0Pxc9zmrSQED4y1t5sLAqknlCcsdBrJr+etSIGhqQc9c5rrsS372LDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwpZ0R/89UOVEOt0c4OEEetGENW7Mx/A1DT/d8ft9vIOEXuHf
	c50bqXGPkWS9MMmVqJCWINm9SoCCdYrvUt4BIOpgF+t9krrBmjTTKs22MfB0mg==
X-Gm-Gg: AeBDievLMwT185MBQwhy8TRSvMa9hwr9RiAjf7MfpbNydqTCFAxmmuv1FEo8sB3pDZQ
	f/T6kzN2+JQK8bhfrQ87/eb59v0dgdeM9wF6kbbXyuyMZfaykE8jDmtEYl155S/G7ZxhzfFuC5H
	zKHfLE9KHjRfvwJQBcyKP/F1uhVK6mM0cgU0GWmCi6Sky/zUEKzyuvqeEhOqC1fatBK0jtvIXIU
	NLWv8RRYCYVGbUF88Tx4ZUjEdsHs4zZyq0Hop7Gyir8nGyqUgo/nqDGehRteoufONXgYwTKxFRG
	xZcmFlKmS6PeeFlzMpprlXOmmW+hnfLCHR7AOU68bHktW+PaW7kM6Ux3bf8uGOLhU9V8ZppVGrE
	Pr1CPvoOglxZYiFoOuS3SRBV5ROtRlOgzy4YvNbtiVZIlMEj7kc7ocy3O0N1e9Ltn+TZY5zRclK
	4RNiCmVSjHn2GtIgof8WfPEqByJY+nofc+O+2i+thGfGM=
X-Received: by 2002:a05:6512:3b22:b0:5a3:f305:a50f with SMTP id 2adb3069b0e04-5a8522d9438mr2292840e87.30.1777586097935;
        Thu, 30 Apr 2026 14:54:57 -0700 (PDT)
Received: from foxbook (bfh75.neoplus.adsl.tpnet.pl. [83.28.45.75])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85b18c70esm64646e87.70.2026.04.30.14.54.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 30 Apr 2026 14:54:57 -0700 (PDT)
Date: Thu, 30 Apr 2026 23:54:53 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: bound wait command completion to avoid kdump
 deadlock
Message-ID: <20260430235453.2288c973.michal.pecio@gmail.com>
In-Reply-To: <CACaw+exdPSVSfdAob7+d-xH=JEjBbPpY_z1cPPU6rzXx4wUZpA@mail.gmail.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
	<20260430104850.352bd946.michal.pecio@gmail.com>
	<CACaw+exdPSVSfdAob7+d-xH=JEjBbPpY_z1cPPU6rzXx4wUZpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B384A4A867C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242212-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 14:27:59 -0300, Desnes Nunes wrote:
> As for how I saw HSE, while testing the patch before submission, since
> I already had the xhci lock, I just added a read of the usbsts before
> calling xhci_hc_died(xhci):
> 
> ...
> -       wait_for_completion(command->completion);
> -       slot_id = command->slot_id;
> +       if (!wait_for_completion_timeout(command->completion,
> +                                        msecs_to_jiffies(2 *
> command->timeout_ms))) {
> +        spin_lock_irqsave(&xhci->lock, tflags);
> +        usbsts = readl(&xhci->op_regs->status);
> +        xhci_err(xhci,
> +            "TRB_ENABLE_SLOT: no command completion after %lums, USBSTS:%s\n",
> +            2 * command->timeout_ms,
> +            xhci_decode_usbsts(ststr, usbsts));
> +        xhci_hc_died(xhci);
> +        spin_unlock_irqrestore(&xhci->lock, tflags);
> +    }
> ...
> 
> This debug version of the patch printed:
> 
> [   17.481330] xhci_hcd 0000:80:14.0: TRB_ENABLE_SLOT: no command
> completion after 10000ms, USBSTS: 0x00000015 HCHalted HSE PCD

OK, so this chip is busted at that point. But it might still be better
to improve xhci_handle_command_timeout() to deal with this and complete
the command, instead of patching here and in other similar places.

> Actually, from the beginning of all my debugging I already had
> `usbcore.dyndbg=+p xhci_hcd.dyndbg=+p xhci_pci.dyndbg=+p` on the
> kernel cmdline, as well as on the crashkernel's
> KDUMP_COMMANDLINE_APPEND at /etc/sysconfig/kdump.
> 
> On crashkernel's kexec-dmesg of the unpatched kernel I see multiple
> doorbell rings stating the HSE:
> 
> ...
> [Thu Apr 30 12:28:22 2026] xhci_hcd 0000:80:14.0: Command timeout,
> USBSTS: 0x00000015 HCHalted HSE PCD
> [Thu Apr 30 12:28:22 2026] xhci_hcd 0000:80:14.0: Command timeout on
> stopped ring
> [Thu Apr 30 12:28:22 2026] xhci_hcd 0000:80:14.0: Turn aborted command
> 000000005921b827 to no-op
> [Thu Apr 30 12:28:22 2026] xhci_hcd 0000:80:14.0: // Ding dong!
> ...

Hmm, the "Command timeout on stopped ring" case doesn't obviously lead
to any immediate command completion, and ringing the command doorbell
under HSE won't achieve any progress. Maybe that's the bug.

Could you post full crash kernel dmesg up to that point? Not sure how
it got to this place.

When xhci_handle_command_timeout() logs USBSTS, does it help to add:

if (usbsts & STS_FATAL) {
        xhci_halt(xhci);
        xhci_hc_died(xhci);
        goto time_out_completed;
}

It may not be perfect solution (race conditions?) but it could hint
that we are on the right track, if it works.

Regards,
Michal

