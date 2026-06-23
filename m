Return-Path: <stable+bounces-267938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S7KrLUF4Omr19gcAu9opvQ
	(envelope-from <stable+bounces-267938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 14:12:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 168706B6FD5
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 14:12:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fZcXdBHI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267938-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267938-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D9C23035A93
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80243D565A;
	Tue, 23 Jun 2026 12:12:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A723D5246
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 12:12:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782216738; cv=pass; b=fUbgFmYGPmo5S8ikBHKinerofG8bm62UQFxlGGLPWaAvcHxfXFaBOm9sTOHLnEhls1pAZthiQYtfdKFt2fW8bu1jEDuRlGjbz6yNygtKhvrqOiEXXAQ0bo3mW4/+tqu+nKcp/yd0jRDCixl3OkvlFuH+Ujkxk4VcL01jDckTtQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782216738; c=relaxed/simple;
	bh=6JyAe9BGDqFggBbuyJh2rjWAqPCqM/qaSqibOnVGAsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCs3SCdAppAx3r8QvZMT+mNxvv++6L/DcZE0n89tll6eLB6bgSRMYGeWnVGVAElSiGbxZeDXdVdr2/XrsTi/VtHO+j6Thf4uILeMQuka7zs0HTDKMsORXe0LLWGDxAJ6jHkZc0FNNPCUhUjJ0nETmypMQRtMlChKS83aniPhQwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZcXdBHI; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51a0188b92fso38265951cf.3
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 05:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782216736; cv=none;
        d=google.com; s=arc-20240605;
        b=XiMDf/4gQKWUifYFX/etjbk6AWxr2lsSFJDOD0IhZkfYEgl9io9sL+tJfcgPNi8/YZ
         QwoeJU4F6biffoP9S7yUN+N0USkt5OVOvrL901LUQogsFancn+EMyVvKfAl/3dZ7maaR
         VZmnEQf+7LKMMl9AJL87o8lg1SKU7+CHA65dHSMycsXHbw3OIzjO2RPcBucM2nI2B7cJ
         QcmlWQIP2MmoPLORBc1WfSuk2li8sN+S7Jpr7uBawMuYJnl5moyfNWsyFP5ShGbupxOh
         JJqhJS6g6uQf6Pw43AoWNJI9tFPxz52RIPopSMvQIGy0tFUmb0BoXZEHgvGZwLzC5nox
         2+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0XABf+2UwJoXrB8GHx1U5vjTNNmx0qFkO08DwV7x+9s=;
        fh=bxbSlclQiwHfWvJ3KP17x5UmGF2KrmYSSB4HV6JwkBk=;
        b=Q76T0NLUatKJicVRD1Kx+rByOQPNJFhQ7z6seeo3yh0V5Cp1JwhZPO+JWFuvFCC48n
         baUEH1dt+cZaDiFjhYEDFMu8g0Ww1howuohiRqX+Aqgp6yvJIt70u/518G5JooEEpB5p
         57HKkOpQhf/SY3fG3fjQmNTKCZqcpI0K0l8ZuozuH2UAanKin9BHdg2RIbznLCiEqoQ9
         10Rl0jN69neud5muHOHX8tP7BRy8EaxZSMm9ZcBJu4fV5k2VuKxNSj7qFioH3uTZ8+1+
         vTn5sVK/26dBnbGHfHYaA0MBFUgekfcloykugHdWxVwm0/zmagDXKKHsIxxJ5n+bjexx
         Dh0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782216736; x=1782821536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XABf+2UwJoXrB8GHx1U5vjTNNmx0qFkO08DwV7x+9s=;
        b=fZcXdBHIki7cowh0TsN7oIrEeRCo/meBgP998nYRoGfu8IVPxe4c5tD7H0Nvbdb2p5
         N1sMDMLlvI6lUkfo1bfTVmDVA2dhkyPFPob0cZhYD2XolO1AVL4ygkoF8QqOTozXeQMM
         6K96/Di+qqh2AiN6XHLjhaMVX3RfifxJx+2MBFR5wIoLC70qWDqzpXVOIDxF0SLP+RAu
         xoJ8gIRrtdVdCopWqdC1Xp77MkvD6XEGhaiCL/qQgJyPFWA084SZZkoTcR2fz+qrzCVN
         BeXP2tQY+EsqtpLyPeyad7qbQnDYpEoi4qaV0oP/1UbbDlom2kdjI24hI1ESomxK4c2Q
         yM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782216736; x=1782821536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0XABf+2UwJoXrB8GHx1U5vjTNNmx0qFkO08DwV7x+9s=;
        b=VyQbiWCHOoSaJMat6WmxMzwMPGNDjl2wFEdrIEhxexib3+P7EjUc6VmHL7aPrHqHif
         TAVy/dYSqFrtdzKMZpHLiQ4OkKYwqISrSdJCL02851jcmH+NJeGT0dQynV8r6BfItxxJ
         Rv6b7LWX+bGvPeN9jss1wRRFLqtopx4fM3MrJa2QA6Nsxcfb9TYbZFCtLXrSaiTTGUaM
         ZynAf+xxNrthpE00/gidAzVPma8Nln/2+gbNxuebGH0225FDEhmSNkgT7gG05pWdYLKL
         VVx8DeRMD4dS3H5ijikY83kP3XQdAMxA/iqvYhBkcyySC5lbkprAi8CgJ3BMPn54HyGL
         bPJA==
X-Gm-Message-State: AOJu0Yye9c9CeH1NyOrt/199RAJwixnJ/dUF7P+no81POhdLaGXxA/NS
	zUNQqj8UIU6h+QyV+3J5IQ6AdepnELIxyZiQAYZcOcxym5eLQQgsJdDNytNeV7dPx2jv0Hxy0qh
	19tWqLb6i3k8muF7I+ftOs6BWOeI9IbrB/L3tS2s=
X-Gm-Gg: AfdE7ckcYwPT7sjXttYrSCiqG1FS7PJFSKLDJHmo7S0YbRvPxYVZo0D7sL7N7C6U/Qh
	KggQaBZaSdLngEvtHHGY0sds3bRPV4eqlYVmcuODDiyZlrrW0BFmdGpYTRXioF9WU5AUc6zL+Ld
	TpCPXuuyZ1sw+f1k4XtEcwrBBWbiIAcFXY43gN9/lT3Y+/jHp08oTQITcTazVtJ4lscTolf5UPQ
	8866KeVkXBL3jzdIh9r+foVZpv31lb0GLwZTYiIAucg8WHDxUm8ifvtQzxY8ud0/3bbMlTf8Q==
X-Received: by 2002:a05:622a:259a:b0:517:6d75:a2cf with SMTP id
 d75a77b69052e-519e4c8732amr278157181cf.43.1782216736356; Tue, 23 Jun 2026
 05:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623112131.752148-1-slatoncomputers@gmail.com>
 <2026062327-unengaged-apostle-5728@gregkh> <CAButv0efpYUSmOaqksOs0C6To6n+DQQ7vdQFq-pQWwK6Dfau+g@mail.gmail.com>
 <2026062345-kilobyte-tubby-4425@gregkh>
In-Reply-To: <2026062345-kilobyte-tubby-4425@gregkh>
From: Michael Pratte <slatoncomputers@gmail.com>
Date: Tue, 23 Jun 2026 07:12:07 -0500
X-Gm-Features: AVVi8CcVqnW9Yq7D5z_TWavhptVBP15QC13JDeI1mHDtLhKGxcnZ8UmQBBNuVPE
Message-ID: <CAButv0eFzEDR8oQEQUOk33J7j-G8gCQjx5Kcsmrty=ZwGfS1GQ@mail.gmail.com>
Subject: Re: [PATCH] s2io: only arm hardware LSO for GSO skbs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267938-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[slatoncomputers@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slatoncomputers@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 168706B6FD5

On Mon, Jun 23, 2026 at 6:41 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> So what happens when 6.6.y goes end-of-life?  Why is this driver
> removed if people are actually using it and willing to fix bugs in it?

It was removed as "unused," but I use it (Xframe-II in a Supermicro
X5DA8) - which is what prompted this. I'll pursue getting it back in
mainline instead: a revert of aba0138eb7d7 with the fix on top, which
also addresses the EOL question.

> I really don't want to take non-upstream patches for obvious reasons.
> And for code that has been removed already, that goes doubly so.

Understood - withdrawing the stable request; I'll send it to net-next
as a revert + fix instead. Happy to test and fix issues as they come up.

Thanks,
Michael

On Tue, Jun 23, 2026 at 6:56=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 23, 2026 at 06:48:18AM -0500, Michael Pratte wrote:
> > On Mon, Jun 23, 2026, Greg Kroah-Hartman wrote:
> > > Why not just remove the driver in older kernels as well if it is not
> > > being used?
> >
> > It is being used - Xframe-II (17d5:5832) in a Supermicro X5DA8 on 6.6.
> > Please keep it in stable.
> >
> > > And if it's not being used, why is this patch needed at all?
> >
> > It's used and broken: since v4.2 (51466a7545b7) s2io arms LSO with
> > MSS=3D0 on every non-GSO TCP frame, so the card aborts all TCP TX - lin=
ks
> > fine, UDP/ICMP ok, but no TCP at all. The one-liner restores it.
>
> So what happens when 6.6.y goes end-of-life?  Why is this driver removed
> if people are actually using it and willing to fix bugs in it?
>
> I really don't want to take non-upstream patches for obvious reasons.
> And for code that has been removed already, that goes doubly so.
>
> thanks,
>
> greg k-h

