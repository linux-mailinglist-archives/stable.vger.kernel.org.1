Return-Path: <stable+bounces-212800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGkUNDqXe2nOGAIAu9opvQ
	(envelope-from <stable+bounces-212800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:22:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC14B2C80
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFA4B303AA88
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFCE344054;
	Thu, 29 Jan 2026 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDvwsPb+"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F27347BA8
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707186; cv=pass; b=hAd+TjVtDkyhZoBnaMXB6zAy2dVTuqtY/EtMcMBbXcm+R9puTy8wJNQq2ee3H1mqcRdzJB9FvQNe/4NFisfOk92MjvbJS/fUxWZunWKVxBgCiA/+xKTiyRGzcyle/+IKDsOWBZFsPwN5cyacoHTVeDIqKOu4bP4874gr8icF/Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707186; c=relaxed/simple;
	bh=qMPRz8CcuEOu8W8eWVzoigWcXHvvgJkLwm4p4aQZMMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDwfIzpN1jpJQCZAKF+1Or0uCzOEwDwcJxeJTWH8bvtdKpcfQaBFoTh3sIW99Qt4qYe6EzaXEBGCfK1lasnihEs/VMBftkpcf69hBDm8tgS1nKe0BKslI3YXv5IT+YsRYTUbULkDAZCkDsnbsAuKW752IEKogU4wzBPdOJ1GCvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDvwsPb+; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b78649941so8214e87.1
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 09:19:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769707182; cv=none;
        d=google.com; s=arc-20240605;
        b=Oysoj2vJmW0Q8W/ArUki8uoKW21Hr4AbSN9PovxVtuebK4vR1daE28OotB8M6v378I
         wzGvo0KaKmtmG7KbiwQCc/jbXTNrFJoOt175X1sbpgYs0i5i4XmyMkHzpYajD+6Fb37V
         41yLkNtD7YVlVoxJvNYZgPI6o8oJbAt+afA63Vb14VM3nCKa9fJkKbyQVG3PfAAx6k2X
         61IwmtMHTV8HY9MOjFhhMpXS26+laC1kwLlIy5T/W6HP5biBxdbBARBihNQlQ/Az9t1X
         /jmPyQAULikvER26ztCDVrJH1XQsqh414LCnM0ulEUn86ItfQBaOJ4r44oDDiQxci9rF
         yp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qMPRz8CcuEOu8W8eWVzoigWcXHvvgJkLwm4p4aQZMMM=;
        fh=L5z6z71qM6VZNS5lC6n/EQwrn8tjiEcut5okXrNN684=;
        b=YUl1ivduynWu6F2WEiOUNcth2kQGAsmyB8LWAmK/HEYm0v36csyJTwIogj2LCXmeD3
         TazdWyC79qjkxpuwkTBtYu9npQix0iBlOKKT+9roWs2JZqi/uXJJkLxqDZRGJ8t9OZzi
         nVe4dwV10CacsqTPJL49R2KdE6WsCed8rXi7T0z+dxNqMojiKiAH1kC3pr/1AVApxhc3
         jOnw/Jwtx8Fiq5Ckuhfg3VGxk8fqCEN8he2tuiDx+lIHniTO82rG1U8NNVnN1dyUggrR
         cxnWHJhYAe/7v1bIHTLdSb2R3MuOiR+kmIYB7OOAAIOjLOThOEH/6O22OyMDUSpX1gjN
         YuxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769707182; x=1770311982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMPRz8CcuEOu8W8eWVzoigWcXHvvgJkLwm4p4aQZMMM=;
        b=UDvwsPb+ANO3W4AKTOo0JXcF4z8Lln48aRCrWENHtJUCbddFTKI03zaIcBr8iDrKQC
         ah3bBfGzuV2b+8a+ZrEg2lYGFEmh1023cmzPl89FvmlvcuAWsjnfaIjh1G22o9wdZMwG
         Grp8MPPQ2EdlmgUkW8ntltzOb725h6MT3bVaZ9WcLFkClREolTMi9Ozjj8F6wku865a8
         CeCXKhn0tfUp+GKD3XoXYLai8YFTFPkZtQ0CwGMdgw8wnJ+PetUXhQOHNK/x4pZWY95K
         SytGFkUU5qTBZUokbET+J6Cj5rI3kstbADvFX0yx7M9ufQh3/61Wy7zXO55jQW04i8Si
         Lq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769707182; x=1770311982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qMPRz8CcuEOu8W8eWVzoigWcXHvvgJkLwm4p4aQZMMM=;
        b=nOXQRARm/6iW+VsMQN5p4Vxqw8lEu8AfSe1x3Sk0l9AlOSj+LAxEG299IUxWJF5ega
         5iQdoxbLmnzXR3c1M7Mh+NuaUeE2Z8SkKjPXstsqc1IpsTiyNTFbWyI8ctZ/sqbaBnVZ
         4D8Q88dZLIngsWLcRrkKAeZQ9ZIWfzwnVDsmuWORVqTaaJXUFutQ/GvEys+9th0aVgjb
         JJMFcSJBZ9sK2F05xKLEs+pAlKgLBmNN4qIEmSdKzfp/oebm1FZyqvApyi9qLxEX8cql
         UMuIySuw4eyQRI3dH+eUa9IUJ2JXW/2wkM84oSfDui/3nkM9Ipo66E0eCGVjQDzZX+wq
         mkMQ==
X-Gm-Message-State: AOJu0YytlcHOrxIsbryjljW8sxh+H6CVianMnYL1uAbK0I3BBlY4Hdwo
	jG96uDu4EhotSAuOtDSyLxbMIB7l9hQ8sE0R69qLljNq54HCrOPqP91jCLvMvtnYdqE3dl7VjN5
	pRJrpUiBuCyGCvdzQIUA26RmtOSKEYYerxfkmNzhP3hXqcasX1mEaP4iUTkA=
X-Gm-Gg: AZuq6aKO9srdRUJaROrUqhDV3HMPtVP2Rivdn2no4tPWy9ay0XG+G0z/hcUEJury7Wh
	YDxFXMnVgjDTexmAo7cthzdptP/hKK2hXtVOB8jwaAjSQES9Vcw7o1iNBEcDJztx0Nu9tAHUXLg
	A8O36Imwv7CtB9xCcv3yNr4nOsP7AH88Y23rG2aHFDMtI+n7EbjStkEHVS4y1C32PH+8k2OjGcK
	oB8YzGtrIqO63GoMMX02FhZqEP6CRXzQIDxh1hJPijNbDRwKVIPTX2fhHZno88ReZXyXSceUaDk
	oGsbb+sO8XCo2W2Xc4vFJIc=
X-Received: by 2002:ac2:41c6:0:b0:59b:67e8:1447 with SMTP id
 2adb3069b0e04-59e0f534c7emr129681e87.9.1769707182249; Thu, 29 Jan 2026
 09:19:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129070657.678532-1-thomasyen@google.com> <491d53b9-a110-431b-9a5e-3b46d833fdbb@acm.org>
In-Reply-To: <491d53b9-a110-431b-9a5e-3b46d833fdbb@acm.org>
From: Thomas Yen <thomasyen@google.com>
Date: Fri, 30 Jan 2026 01:19:28 +0800
X-Gm-Features: AZwV_QiDG32hkmkX3wu5y7bnnB92Q2_mE_V-LjMXUX5IPKy4NdnxXX0daM1vNFc
Message-ID: <CALw5pqG735L-6-umZspQOKB9DfRHf7D0AfpkRD_=xwX0LtZ2Vg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] scsi: ufs: core: Flush exception handling work
 when RPM level is zero
To: Bart Van Assche <bvanassche@acm.org>
Cc: Stable Tree <stable@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Peter Wang <peter.wang@mediatek.com>, 
	Bean Huo <beanhuo@micron.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>, 
	"open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER" <linux-scsi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212800-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomasyen@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,acm.org:email]
X-Rspamd-Queue-Id: 7BC14B2C80
X-Rspamd-Action: no action

Hi Bart,

Thanks for the tip regarding the tag ordering. I will ensure the Cc
tag is placed above the Signed-off-by tag in future submissions.

I had just sent v4 (to add the missing Fixes tag) before seeing this
message. Since the code logic in v4 is identical to v3, I hope that is
acceptable. Thanks.

Thomas


On Fri, Jan 30, 2026 at 1:04=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 1/28/26 11:06 PM, Thomas Yen wrote:
> > Ensure that the exception event handling work is explicitly flushed
> > during suspend when the runtime power management level is set to
> > UFS_PM_LVL_0.
> >
> > When the RPM level is zero, the device power mode and link state both
> > remain active. Previously, the UFS core driver bypassed flushing
> > exception event handling jobs in this configuration. This created a rac=
e
> > condition where the driver could attempt to access the host controller
> > to handle an exception after the system had already entered a deep
> > power-down state, resulting in a system crash.
> >
> > Explicitly flush this work and disable auto BKOPs before the suspend
> > callback proceeds. This guarantees that pending exception tasks complet=
e
> > and prevents illegal hardware access during the power-down sequence.
> >
> > Signed-off-by: Thomas Yen <thomasyen@google.com>
> > Cc: Stable Tree <stable@vger.kernel.org>
> For future patch submissions, please place the Cc: tag above the
> Signed-off-by tag. I think that is a widely used convention in the Linux
> kernel community. Anyway:
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>

