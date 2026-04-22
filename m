Return-Path: <stable+bounces-240343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJJ7I8vl6GkHRQIAu9opvQ
	(envelope-from <stable+bounces-240343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:14:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F38B7447BD6
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B0D3303AB6A
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38013148B4;
	Wed, 22 Apr 2026 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu1k790T"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AA72E5B2A
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870552; cv=pass; b=Rz1uz9GKnSDq0Pu3udL9hoVM29dYdh0Zi8blhyxlZPQtBkttVv8s+U7NQH3Z5NyLKajF+YIRee2eb4LLT32Vo83Z49FPB2AsAXlPOFUYJv4Lx0thgN+1lh9p3swZ6Pp095UlishEOBB80a6P2rsaW8jD8APKv+kvAOQ1P1ZYtNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870552; c=relaxed/simple;
	bh=sBxpp7G1hGSRFEzvlZREZSsh2ubBEhHltUcHL8EqxDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaqpf9tFU2nYU5vtgvLXen39tfdYzktqf2bt5ZU9HWZSB13BFc2vn/eW9oPGGMVU3/9W2kUdriF2GYOF+XFmSARNDo48I4laE8EdN6M+w0DmcuKNLHdkvOccXNnrz7PkAWxQNoSowT/JD3ID5LM7+t6nUMzrzlrcbow0NDzVrpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu1k790T; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-479f7e75a6bso680690b6e.2
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 08:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776870550; cv=none;
        d=google.com; s=arc-20240605;
        b=VxMwkqKUmjNeSumwNcgghdNHCgA2OI8mO9yi6xg9WF9L4DaXa0RREtn7G17l2KTRg/
         S+8C3M5ScC31TfNIlvAGPEGen9H1lqRLSI3dTKmHo1Kg7Vw4QGl18aiuTAO3fgpLDH5/
         NK2vx51mYXegDce6qMZOJqpQ6RDCdBeuqsZHHQCt7cuf5eCtK5gXGqvHO/sWROemeI/I
         NXpyfxjmq+xBr9nbCqu5euJFRgDENQ7h4SmhKUyr1S0qfQJ2CmYYDo44GU7WxsJ9qsex
         D4FkG9G+cR12M96lp+sMkm3WbVU7U2kTbdhtnE6N7srr4BcxMO80JDneuH7ULGaQvNB+
         ulNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uGy79cymkiDC4frLILWmwuYDcRF9vSptUaSzopr5FdM=;
        fh=hwl5kscO8cXOYrTucWuYQIpBFFOT5INJ2KBI58rgezk=;
        b=iqKpNzFQ4j9Sa5E96K+/JqqY0+aDUNJ2hitUosK9GItiUQeutpiRjI/3gPAyRJqq2p
         PvYhvfJgHtbfRqfxBditAQSIaHVrrgpusKmC0gAsWKx+EnZh9dk6cdBkk5AL3TRSEp72
         DXgCYAj27r2VWAdihijd/0nPPTXWwHM1z/4u14WDVR8dkYtZe55ZXi1JgpMYbesHU7GU
         H5XGD0LYSfCS6qh3JczHI6NSsu6P7GdPevpRCrzVdWGyWtZWpN8RnCeHDPjpoX+99MQg
         9RtF1NyO4lXP3CnItVypeOQp+nKgav2lyW+eQWkG+yzykrByadPUYIsr0IU5nJ8Gpiwi
         xO4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870550; x=1777475350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGy79cymkiDC4frLILWmwuYDcRF9vSptUaSzopr5FdM=;
        b=Tu1k790TqOsO/U5rOP+48M0w8hjkNuUFjXauUvDXCqObndd/lfyO73DKtFQ0VHcFI3
         7ahPOnQggXYvJfXLiWnuQoj7aWpZ2uph32kULXwy7qAchLR5j3haafXO0jaOr5yAqlLE
         yHkGZrFC8OtWw+J7ghFKeb+lOnXH+GBvWtgCnKZSVZasxT/eMSgak0amFC+2wcKZJs8J
         hWs88y39jF94r58MlKXiBI6dxoEaao57sDUBYsHlzVZprqgVDqlqkdTfonAFOICzM14T
         kPMEoyRDpkP+YG/4Ysan27A6H0z1qoxzd/ZzhrHg8z7m0OfY9rMkECjiGP0lIHFZYdxT
         iF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870550; x=1777475350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGy79cymkiDC4frLILWmwuYDcRF9vSptUaSzopr5FdM=;
        b=PxBfC3+W45Fz1I29DQO6Ourrw4poLFblyIJYFOlUt/yAhqJMEzNv9TlVq7EGczpBDO
         JpYWGzwrbJjhfg+L2joJCdZ8K5DVmuemAiQOr6IOQERqDw5Cw3xEdw00MAFyU2Jkm/6D
         3nn4PNOT7XcGFeaJTJ+1KS/5kY0nuubi3Kg77CIE9aLt42vIiZoW+9BWYBswCHsIaaWR
         jOwbaPGIkVdpQjrmfq5sh+/+t5UUB/IF+oNmiVhd7mUe8f9OH7moWlMYVTs4pP00jCTo
         5WFHL8KlVTwMaGCd++mYrlvozoHEyHGKD1HRe3mPBoivU0tfqQL/19R7TXWIyQ4Fa6j0
         DuQA==
X-Forwarded-Encrypted: i=1; AFNElJ863k0IvvCSDHMKmTEl6Cng8+wNJRFZsVdqtoz3REzEuWd30N9mp81ikq0r6o2efd6TizZHmLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyClPROl+ZqdB6dZFfHl4RIWM6LnjrF7AuT/wLUwd1+Kuy9Uc4x
	MQlzUMafdASvkDKHZHMjtk0Q15JioeNCdll6pC1VPytDYqkY/NiPkEKUEFyeYH0OZ5c/I0VMrq4
	/9Cnnt+kX9wcti2iueh+Z4gOMVc89Eys=
X-Gm-Gg: AeBDies3eHMIZ6eUbv7SBf51S+yehhiaTsZkSskSMFg5d812xAfzf8RL3y6fbyzHIsO
	dQzI8KYLRy8wVoKbUKUorFktsN2sg4yDDV89AsiFoPd8ECo+ZIehvK6GKwAtbk+qtBgpcQycRBZ
	8641D59S4B01s2FtJpcXi8/78z/UmA5zVBvKUTxq+V6MB+4L0DgFgKd5J2oCKNoC2JWTpnnPlQU
	AFXV8VxtMXfntif+h4IGeyLBJs/5QchAc+e3nQIPpXO8g7BuEOltb2Uqq3PZ0KPo5S3GvdPzSyu
	F9kll20nhXrQ5+f1Xjx5muqjY7iwvn+eT64EI2P9kIX/kJlDJbg2ueeJocBMFojv0cqGGqVDrN4
	iMGJh
X-Received: by 2002:a05:6808:1a0d:b0:479:ffcf:52e7 with SMTP id
 5614622812f47-479ffcf56c9mr2116979b6e.45.1776870549931; Wed, 22 Apr 2026
 08:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417221628.1674866-1-michael.bommarito@gmail.com>
 <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
 <20260421135639.3185653-2-michael.bommarito@gmail.com> <CABBYNZKS5Prm+BTkpdPgArgODTEDgHXLjecfux=3ZW0r2x=UXw@mail.gmail.com>
 <CAJJ9bXy8CVjC4xG0zBcxi9xtiep33-uRGSysL1Q3FiqCN7Rt0w@mail.gmail.com>
In-Reply-To: <CAJJ9bXy8CVjC4xG0zBcxi9xtiep33-uRGSysL1Q3FiqCN7Rt0w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Apr 2026 11:08:58 -0400
X-Gm-Features: AQROBzBpAa3bFHNHHM2cSEM-QAiFopVAaeqTBVT_jbR8_JmNoVXMRcDVmd8ZkqI
Message-ID: <CABBYNZK+o0wwOvjoz9w0ju4SoXpt6PM1xQwXU6OozVJLstWMGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: L2CAP: handle zero txwin_size in ERTM
 RFC option
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Mat Martineau <martineau@kernel.org>, 
	Hyunwoo Kim <imv4bel@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240343-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[holtmann.org,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: F38B7447BD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Wed, Apr 22, 2026 at 10:58=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > This seems to be going sideways:
> >
> > https://sashiko.dev/#/patchset/CABBYNZ%2Bf3pur4cSsanQ1kvv-yORp2E0qmVLt9=
si_%2BFnnJup4Ng%40mail.gmail.com
> >
> > Patch 2/2 seems totally broken.
>
> Yeah, not a great turn.  I am struggling to figure out where to move
> some of these parts and where to put the guards without touching too
> much.  As Sashiko pointed out, there are some preexisting bugs or spec
> questions that I don't feel like I should be touching unless we expand
> this to more of a cleanup + hardening patch set.
>
> If we break this down, there are now ~5 different issues in
> adjacent/connected spots:
>
> Ones I was trying to hit or introduced:
> 1. Zero txwin_size in inbound CONFIG_REQ (ERTM RFC) - original bug.
> Need to balance normalization with spec.
> 2. Repeated CONFIG_RSP re-running l2cap_ertm_init in BT_CONNECTED -
> original v2 2/2 target.  We need the guard somewhere safe under the
> state model.
> 3. Zero txwin_size from userspace setsockopt - original v2 1/2 hunk in
> l2cap_sock.c.
>
> Pre-existing issues:
> 3. STREAMING -> ERTM mode switch via late CONF_RSP - pre-existing.
> 4. l2cap_sock_setsockopt_old locking - pre-existing.
>
> It feels like the safe solution is probably going to be at least +100
> or 200 by the time it's done and more than just a hardening patch.  I
> can take a spin at it, but I will probably be slower and more
> bug-prone than someone else.  No pride of ownership here.  Just let me
> know if you want to take the fix over or let me try again

100-200 is not too bad though, if there are splits in, let's say, 5
changes that seem doable, especially now that we can sashiko review it
and point out if we are missing something. Another approach would be
to leave the pre-existing issues to be fixed in a separate set.

> Thanks,
> MIke Bommarito



--=20
Luiz Augusto von Dentz

