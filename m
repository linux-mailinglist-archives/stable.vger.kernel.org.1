Return-Path: <stable+bounces-238259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIxwJVuD4GmgigAAu9opvQ
	(envelope-from <stable+bounces-238259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:36:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D035840AB1A
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B52F731016F8
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 06:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E2837B002;
	Thu, 16 Apr 2026 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skxriIEd"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10D37B014
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776321298; cv=pass; b=ULnBQVTz6Aw6jCgDj/b58EHyOFRoeU/ta7infvLsqtuNOLlF+aNjI3hrTmmbXV0jCEtpKrfNRpJ+DW2ALzbHZ7VpMyzPsjYNg3WPFgUNvtY/kcIZzHNQG8RQssHR0vPHOjgimXf/u+eS8rCNZ44MiC7Z4bwCmUZYXXf+wh22XYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776321298; c=relaxed/simple;
	bh=zkE8BBtcWTfxhbp67Vqhj2WQ70db3sr/Z6W8Xr2/kkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T61EVUVXAGTAvAuvMfVJxmTatxvA3Vng+x0ucldJtzbNFD/3Mjrii/bbhKxfEIP7mOjvegdoKeV60WVcKtnbP+/QV1R/kO0xG4IGfjiH5fhKSqbkJ3fE4Iy+yBr4ISytn1zsW4RRbWKhJgXXpsyeu7L/HkGH1aTk4D6xVvXwt34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=skxriIEd; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6501547d7edso7205900d50.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 23:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776321296; cv=none;
        d=google.com; s=arc-20240605;
        b=Ecrwdfl41YCJLVSvsjTWxRzzQQPpBdI8B1pOhV/0Nys+fyK1jxNogsL++tlUiKQ/m1
         jk28tzRVC064OcT1R0Tm/AiWhXSJMyiV6y8aqhIUg8VNa60qESIKfphntzNYmXhGx3n9
         WYlpQ+5rXkU6GhANkYFIDBmJ449xU1CnlQpwnDcnIspZRZxxTcmuB5jJyaTXz/b635o1
         +Rm9hS+WH1SGhnMlkw9RBuS1kH530qlMWsV+NElJZ+3zrN9o89W8Q8I4CFw2bSr+6H7q
         I2+D2EsHwKDtA9PfYg/3PYdK3LkItnNWn1tpgfR55FB8Bx7PO2TdMWT+xPYeSerWPWIM
         7Inw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6WBIGgQfqXhM97YbaJTI7B6LyiqfGzNm6rs6snpZKzw=;
        fh=4mVnVUK+YPl6qa5dkgN61CIx81kwN4oYFzn8rXSyBb4=;
        b=e+OQLEHtjIVv/GZcDpLGH/GpZSBCm4QGJEISy4qZJTf/O45U0TXy5Y36h7WXmssVrA
         +AOYcG9iVs/unvAkcLIOmm8mZGY2SNmiwb2GeypQTPdNYkIxZ9qJha+j4UaivBIr3/D/
         H3ipgnxd415zr4bt81O1R8fS2lqjMT0aCMdDq4p27385p7RxqIxKbgZ8Dm1AJPUuMofx
         rjFkqgYg+SCYJ7t576rqh09DWYgMlSRuIDbyyBGLo9AZzAbw5jN7J/fjU8xZIdJAQi6F
         Ktn2zjZCRxp3Ei/4KkkU+NUShZTKuQGdwPzFKUb9/PDUUPYmwafN5vBzvAllLUH+wJxK
         27cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776321296; x=1776926096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6WBIGgQfqXhM97YbaJTI7B6LyiqfGzNm6rs6snpZKzw=;
        b=skxriIEdwSjqBRMsG8xs3mf9nTwcXFgl5P1Heebx4izhtUdhBD+/UcL2Y/5Vs0JZyE
         cx55vP/KEGzceTxdi/XFL5PGAU8sbQoj1KIuGWrlIl9Booy/PUXoqKszxtEVAcyTpXwL
         cTU9NEu4vTSDYQtJ0EMmM6nqfHaaxhWokVd2uSAKsK6o6hwmkxyFLEJvRzODQcnIgZy0
         zBnCEXrmeUHTun602imJhotTY4OSWIe3XURcwq4trzBge7DBQ62uhaNl0CTTWSfNUHXx
         u4lzMCZaVA4fTe/XKFfiJ3AoU5ojovOVZTp6HaBvf4tQn0FQpO79YO+NSnQyjy8XJKch
         JyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776321296; x=1776926096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WBIGgQfqXhM97YbaJTI7B6LyiqfGzNm6rs6snpZKzw=;
        b=crtNv+MjVrJ2bDD9WQuxjkb6lmR5S/1Y58vXB6zOFWDTHWtlfRhaOHSmZKvUd2BEAC
         SS5o3TOR2rpZALb61NPPCK0ts3cR87L0VNZLtj7zPUn52scLwZGWe2kZqYVZiypN21iN
         plFNLhRmVCWOohpCfBhSxkQzdxbCJLqs1RrFJhWf9xhxo1xAFvk2ojwSfftRaVBhAVFg
         XCAfkbmc1Dy9K9MJhtsCkEOOs8uagcctjJbUqG2nIxezOMePevZ5T8FIRpwnmgeeDVtT
         3qpAztMnGvwfd5YnP/YYQPVOfQKHzc1iYHGVemTO/Yca06fC+wQO58CjbqLdTJb+1ZKR
         bmFA==
X-Forwarded-Encrypted: i=1; AFNElJ+sREUyx+cSa/oQdI2pGzfJWdjka+YhNhvVZiWzYwl6Pa1qrp04RTqv+zMDzVwiaJntZBQnnRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHJMvgjRNuPG4TRhcz8xk3XPYNWcN6wanOFzv7qq5f2XXyh8Z
	npVPz+oonqq07lvNxyartk+f1WnJJ/tQBz6uE/VKiDpBYcgsX8sa5Qo9yF6MRdAb1SzLaF7MAxs
	eGrwCIFE7yLFQ36rUaUACIUW9aZ7xoh8=
X-Gm-Gg: AeBDietgCYxqq6uWyKeZAlbe7i4EFoBaZVsFoj1G8hcUGC49W/Stg4YZyEb7QKgrkIH
	1vKUNaK8DrrTiqkv7OPB89A34qGgJtatIrizUmF52Mi52nbDUk5E+agrsYqX4ew9kap56vvpsJd
	lGKb3ZF1tJVuU10nJ0PL9/wtPoOrv9XGiAHOiK2f4dIYX154m7e5yum6GG//2ULyYZ5DXa//Qiy
	pSclf4doifm0T+wmgU5TVVZsY01qYNnKzA1gUyBFCnsqy5Hn5PGzPhCv6UbjG/OPBfjWJlCs7xI
	9pIbVTz2OJqxjtINdA==
X-Received: by 2002:a05:690e:1209:b0:651:d23c:3d70 with SMTP id
 956f58d0204a3-651d23c47afmr12655185d50.16.1776321295868; Wed, 15 Apr 2026
 23:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415174159.3625777-1-lgs201920130244@gmail.com>
 <ad_WmuauLJ3xDKqh@J2N7QTR9R3> <2026041603-guts-crested-ef76@gregkh>
In-Reply-To: <2026041603-guts-crested-ef76@gregkh>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 14:34:41 +0800
X-Gm-Features: AQROBzCOpZzRmD41Y6QW8paZXFQAYd1mYTjiI8Mq73St9Vcp-8vYTmlQsIfc7_Q
Message-ID: <CANUHTR89FUUFxL-TKxOOAugNFp9oR3dc9Zf87-kEEXSrRWxk5g@mail.gmail.com>
Subject: Re: [PATCH] arm_pmu: acpi: fix reference leak on failed device registration
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238259-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: D035840AB1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mark, Greg,

Thanks for the feedback.

On Thu, 16 Apr 2026 at 12:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 15, 2026 at 07:19:06PM +0100, Mark Rutland wrote:
> > Hi,
> >
> > Thanks for the patch, but from a quick skim, I don't think this is the right
> > fix.
> >
> > Greg, I think we might want to rework the core API here; question for
> > you at the end.
> >
> > On Thu, Apr 16, 2026 at 01:41:59AM +0800, Guangshuo Li wrote:
> > > When platform_device_register() fails in arm_acpi_register_pmu_device(),
> > > the embedded struct device in pdev has already been initialized by
> > > device_initialize(), but the failure path only unregisters the GSI and
> > > does not drop the device reference for the current platform device:
> > >
> > >   arm_acpi_register_pmu_device()
> > >     -> platform_device_register(pdev)
> > >        -> device_initialize(&pdev->dev)
> > >        -> setup_pdev_dma_masks(pdev)
> > >        -> platform_device_add(pdev)
> > >
> > > This leads to a reference leak when platform_device_register() fails.
> >
> > AFAICT you're saying that the reference was taken *within*
> > platform_device_register(), and then platform_device_register() itself
> > has failed. I think it's surprising that platform_device_register()
> > doesn't clean that up itself in the case of an error.
> >
> > There are *tonnes* of calls to platform_device_register() throughout the
> > kernel that don't even bother to check the return value, and many that
> > just pass the return onto a caller that can't possibly know to call
> > platform_device_put().
> >
> > Code in the same file as platform_device_register() expects it to clean up
> > after itself, e.g.
> >
> > | int platform_add_devices(struct platform_device **devs, int num)
> > | {
> > |         int i, ret = 0;
> > |
> > |         for (i = 0; i < num; i++) {
> > |                 ret = platform_device_register(devs[i]);
> > |                 if (ret) {
> > |                         while (--i >= 0)
> > |                                 platform_device_unregister(devs[i]);
> > |                         break;
> > |                 }
> > |         }
> > |
> > |         return ret;
> > | }
> >
> > That's been there since the initial git commit, and back then,
> > platform_device_register() didn't mention that callers needed to perform
> > any cleanup.
> >
> > I see a comment was added to platform_device_register() in commit:
> >
> >   67e532a42cf4 ("driver core: platform: document registration-failure requirement")
> >
> > ... and that copied the commend added for device_register() in commit:
> >
> >   5739411acbaa ("Driver core: Clarify device cleanup.")
> >
> > ... but the potential brokenness is so widespread, and the behaviour is
> > so surprising, that I'd argue the real but is that device_register()
> > doesn't clean up in case of error. I don't think it's worth changing
> > this single instance given the prevalance and churn fixing all of that
> > would involve.
> >
> > I think it would be far better to fix the core driver API such that when
> > those functions return an error, they've already cleaned up for
> > themselves.
> >
> > Greg, am I missing some functional reason why we can't rework
> > device_register() and friends to handle cleanup themselves? I appreciate
> > that'll involve churn for some callers, but AFAICT the majority of
> > callers don't have the required cleanup.
>
> Yes, we should fix the platform core code here, this should not be
> required to do everywhere as obviously we all got it wrong.
>
> Guangshuo, can you submit a patch to do that instead and ask for all of
> your other patches to not be applied as well?
>
> thanks,
>
> greg k-h

I agree that fixing this in the platform core makes more sense than
handling it in individual callers.

I'll look into the core code and send a patch for that instead. I'll
also ask for my other related patches not to be applied.

Thanks,
Guangshuo

