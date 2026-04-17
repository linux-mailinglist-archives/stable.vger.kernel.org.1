Return-Path: <stable+bounces-238528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2jH2FDPD4mlN+AAAu9opvQ
	(envelope-from <stable+bounces-238528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 01:33:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA0941F2C3
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 01:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E81963015E3A
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 23:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BDD34DB74;
	Fri, 17 Apr 2026 23:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzu1dg8b"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD866199D8
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 23:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776468782; cv=pass; b=lhy8D+mO/SjrsPRdosQHDzujyNPm8RoxxMEfX4nx+WmkTTqc9Kl07u4Mw2gZWOesmUrNhnuFEkymX4o3/fECTx0m3DdLyulIm+7HE/dypuFB4F1l3hGR10SJNVChj+RECM1V64Fdq5cPj39YKUBmdawK7ZGVU8wqQjX1g7J/gig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776468782; c=relaxed/simple;
	bh=qUzJ2BMhk2qoIHxwUszMJ2chiqeRX6VobF8MF0524HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7FzOY1nyEV6i3FNdXfDLuUdZXEx9uPXvcnGsmod00fk+dliN/PhskzCcJFZvKDMqD2+0ZWxvFJvr2o2y1/TjyxgRxb2vIlxuu2RgANPD1EeoiVrAJRH1CFXe2k6GGuuamMoEXpso7cnmLslanBNLmY6531nSB200Aw4V5DG//4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gzu1dg8b; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d836552daso230101cf.0
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 16:33:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776468780; cv=none;
        d=google.com; s=arc-20240605;
        b=kDyuzoRzvm31GFGc39TCHzsSeBL5QJJH0ESqixD7EOVu5IXJw7hgHzrUNEjEImn/1Z
         D5TyoIVE3l7YlsfJNssv4USmO3oFGM01qmhz5o/5ohHCG/BEwrU7qY2x1LbMZHzRqcVV
         5azhHqpuGSYT5/UZn3bnHSu1fk+yhzgj+5106QPUpO0SkvPkBQ4ki6tnTDerZNWVpsbv
         iKE5atnI2+IEhohIL4rA74TjPE/gcku4QjndGbJy/SidzyoAgRQjUfXPIzPLzph7wnAk
         uakuSpa0LTDlRFUO6UkvsIQM9AeRIf0qgoPqo3PD5QHDvA+h88UpQx7CveL9FhEk57Os
         915g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qUzJ2BMhk2qoIHxwUszMJ2chiqeRX6VobF8MF0524HA=;
        fh=M1cIVfiI6R53U7tqLYIw04E9otkunkl+qm4+fcp3wyg=;
        b=S8g2JHil8QkcQspYgxSOAIfv4BT5TvcWEpIj4lBrtnAQAUZCLL4yjZPKN3Vm+sI7f6
         XgTSIMa1KIGtutGbFa9xwHxIhpWcaMe0Pdbbq6dDpyyaSh3yAPxKkEl/UcfPhHIZery7
         u5tphyb1VhaCl/0XE/ps7WrneMUyNEvIzNpWZV+Dz9atmb8qel7fKzQz71nqyQn2J9Wm
         t0xBTA6myYyjr7nA71xr70zoK6by8MmglhSWCyxcWhaMxVjwpxOxWph/H7JiocRFDoau
         HBvAagrhQZrnXjxhRMVo4ut+NMANGbVGPFBNynhOgjs0/0c9CKOEwqLMQikE2H8BB+Y3
         F59A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776468780; x=1777073580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUzJ2BMhk2qoIHxwUszMJ2chiqeRX6VobF8MF0524HA=;
        b=gzu1dg8bNTz5teQSYFViHxRAbLanteNSjeiG/nTFmD4XSXa4Es2EgxpILRcRyCDDFL
         3JnrsXbohoyX1I4haFbSvHBAIo22fE4RwpTUX1JMRmfKi4IJoxANIZfaWKLK3B1er28d
         p9GB//Yy8oa2q0ruuQPZvbEsJhhWJBWESU5qtEk79bUKOeIpJ2OXF1ALrNB/naf/P4G9
         6Mej+LvKLFoc/QUHhZRrDYGhUA6s+NMdAoovB4H56primPudJy+0hIdFhfeigMO6XuHB
         hNNXAxMrf7SCg89rGE/UBHuIaqtUaFSOm1F5pqZhsrMxP4Jpm/n3cIEJ+2CxpWwZwBrD
         BkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776468780; x=1777073580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qUzJ2BMhk2qoIHxwUszMJ2chiqeRX6VobF8MF0524HA=;
        b=ISN6mbJNNAF/lk+UyjfiTWXKWJ/p/3i/Ta+MhNhH/aelQ6tTcDsrlvL+GAYa3TrNDs
         Wi6wgze1SvjhuLC/IOczEILnSjF0vWPhwmbYP9jU8ATHrAhp3kgosjAuU2J2Wb1qsSpj
         MULZmPoQ/minMnXBeISQomBxPSiaAnEF3GJyaeAaqGOc88WksxVHbhedzcxsdV5nniYN
         AGvj8MVsfqZwSIvjjypCp7nmS/PwSQgLTuyTYbbuBQPUO6lKftotqlJi1PECRB80t6hP
         pM7KdhI6o0P8gT/vByTzQSPIZQ5MQ8ROIAHgPCho170FqtV4RetAdkc0P1Ui3kjROHhU
         IzHg==
X-Gm-Message-State: AOJu0Yx1tmJK1XFw00ZyVnisBYTJaOj0GZjO+r7WPNpEa0W0cE47nJGa
	wDVAoVFN1ip4gL8KAMOyVSWMz49kyk6oLGPtPOXCYk+uC+OfuFndlPqZ2JBhe0rR8JVp/RfJWne
	SJagyAOP7koQya76XMvWctru9y0kSw3WoDtp9Nsm+
X-Gm-Gg: AeBDies6GPsIjKy+oV1MYF4dq8FE9MNfUhcn3dYzJMYuRvXl4IbopMEQesFvVLf7rjL
	fYKszgoOU9P0GVwAGH0kasqsZBfsUuhu//+HFGErZ1X9hJ/rQlm5zm2Pi3BoZs4N3Suj8wRQgj5
	f7i2mjNEoA+q6ytwAbmYr0KXPz7/e8TD17nEeHr8fpnW3eb9ANXX7GGD2TMKgKrOQiBQe8VW4qL
	WdAgEpFi/MtfuEvnvtcLAJpzlgTNSErn8V81036Rq5tAaPzdaAjasVbSPNHbmdDoUjU9snz55Wb
	UcAuwKaOlXrFcyjiZ4NR5Mg/uHuSB/Q+IhSJe6w=
X-Received: by 2002:a05:622a:989:b0:50d:637c:cb64 with SMTP id
 d75a77b69052e-50e42a0876bmr5956351cf.6.1776468780182; Fri, 17 Apr 2026
 16:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHWLEDHfXZScF5jNDzgOxGXf-MBDcVNtqW0DbNz8Ra8rtcuL+w@mail.gmail.com>
In-Reply-To: <CAHWLEDHfXZScF5jNDzgOxGXf-MBDcVNtqW0DbNz8Ra8rtcuL+w@mail.gmail.com>
From: Chenglong Tang <chenglongtang@google.com>
Date: Fri, 17 Apr 2026 16:32:49 -0700
X-Gm-Features: AQROBzCRDoRoqlmFhgpm5PRxW9yTaV4weYU3Obvq1Py8PtiWbd_glLtwlJLTctM
Message-ID: <CAOdxtTbwipkyAfDakLAB6aVp6YkPWtKpDdVDUTz88WDB-18HXQ@mail.gmail.com>
Subject: Re: [REGRESSION] Return change in 6.12.80+ with volatile mounting
To: Derek Taylor <ddtaylor@google.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	Kevin Berry <kpberry@google.com>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238528-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,google.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenglongtang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9EA0941F2C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CC Amir,

For example, containerd 2.2.0 uses `volatile` instead of `fsync=3Dvolatile`=
:
https://github.com/containerd/containerd/blob/main/core/mount/temp.go#L91C1=
-L92C1

On Fri, Apr 17, 2026 at 3:41=E2=80=AFPM Derek Taylor <ddtaylor@google.com> =
wrote:
>
> This change seems to have so far affected at least containerd in an
> issue reported here
> https://github.com/containerd/containerd/issues/13250.
>
> In stable versions 6.12.80+, commit
> 6c0cfbe020c0fcd2a544fcd2931fbc366ee3cd12 with the specific change
> being:
> [*] The mount option "volatile" is an alias to "fsync=3Dvolatile".
> In this scenario, code relying on checking "volatile" will now fail
> due to the return being "fsync=3Dvolatile".
>
> #regzbot introduced:v6.12.80

