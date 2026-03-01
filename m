Return-Path: <stable+bounces-222443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJauFN0RpGlcWQUAu9opvQ
	(envelope-from <stable+bounces-222443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:15:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C38181CF16B
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72B0B30160F8
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF4472631;
	Sun,  1 Mar 2026 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNzMNEBb"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC8430BAF
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360150; cv=pass; b=PnFwhWk8UiZsWktaWrfRdHkK6odA0sGy8MGC7H1jVdR5o3MKuntpse9ACqWErzqELnsagY/grtEDfuy57+tdE69TgeLEbewivw2ayXLlg4GKGVUHkf0WuHajok0ri7P+JCsOVGOJAAt3MoTVaum9Ii/KPZX2h5J2YZdVfsYUb6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360150; c=relaxed/simple;
	bh=OLjAyN6Cl/Pyodiv3HXj5N+KA0Tf7PM3FolA2LBXiDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6c22p+Y+ZnM4zSrS7eUoAMY3XpXKBNszty4eOlkvz+y64oJaIq2m3KTd0DKs4eqUMQYcpkqSkWRJft3KMTKw7LytQPu4HwQ2UNG8zaPDii5XLTTp23rnPWRzYl24i/jMP7U7tdn6lTnEi9k13dCYFonfZLa7ChfiVFDFO0NdoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNzMNEBb; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2be07cafe27so9798eec.1
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 02:15:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360148; cv=none;
        d=google.com; s=arc-20240605;
        b=gz55fpIp75ML0O2HzuXXQdCmoanv2iqv/cloKKFxHJOW/gCympJ0hFFMP99fy9uP0q
         OBLVsilwEWIVdPjOmIqDmdmF5S+FrKCaXjmufOzbZ2EMsnFx3NT2xQ5uLFoCVca/m94N
         tJczOS8k02fs+SeHKK99T6SjvYHtADgbSEBw/2Nt0PlDafi4g+tfNKhdgxfJP9u1yGix
         9RJ+i+i4yGF+EdSEktws9UAANcw0urlSEwI6QF6TuKXRV6khPXbPpVeBiZz2fA7OGqd6
         RValpL7vrZ2vYmtquh+w+uxfuFkLQYFETpx+Wk/G3Embf7Kqz6KSi9VJJVpY5ft4b+Vy
         AIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OLjAyN6Cl/Pyodiv3HXj5N+KA0Tf7PM3FolA2LBXiDU=;
        fh=6SlAK/s1LDjYOpJGfmZa0f6MYkX0DKJLke/nL7xIdlg=;
        b=Sr2npo5+NjyH5K2jUBPl0Hn9G6ouRJ4r2/1udgtu8+m1fZ6LttN5tvYGAAXqzl65b0
         1ZTKodShL+rPFXKsIBZwFf9F4fZCQC1v8xmt9pnUbZMqxFIedz3DTh+c+Ic9aeZZD4QX
         IJxbzukX+8pco9Yc1H00kB7B+z0b4K0CVGs25DNoyyT6PStReUA1aXwocrGccLApq5SU
         ecxsHlxq0y4YNQ1B1QxsJcAZt1DBgB55Au5FQP31g6RbvYzu91o/dGj9cu502hJ/mFl0
         sfZjpoH//b+9w5oTYamX2kuL+QG91g82TzhBSrEUpuQo8kuqm9Uze/XuUtPKNjX+wDsx
         7y8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360148; x=1772964948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLjAyN6Cl/Pyodiv3HXj5N+KA0Tf7PM3FolA2LBXiDU=;
        b=MNzMNEBbqCropTfG2g26EbsRAul+rg9rnjkg5hG8/jZFKK47vL92WKBM2J1FApdG2I
         E1lo8bPRnG3/h/qYonhA6adqKOA1uBm69vju2WRSPyDLcPWXH4ZDlRN9WQKZAagk56pa
         U1kidPzD1oxj1Q0QQEiiOMuyn5636n0h6Q9IfkjG+lhcH3TQNY4WIt2rzAwhl3h2oLAx
         +MQHBHeYFvPcG2uzIagqgEK+/pwtsbXLB57mu0ZAu9td6F5MLEUuZKYGhCT/Qlmk1LoF
         VdC43N1ITMOyblQSpbo1IcW5+HTvCSxSZ9IzT06cqV5x6q8o799xYm4NeTMxgej7QenD
         na9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360148; x=1772964948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OLjAyN6Cl/Pyodiv3HXj5N+KA0Tf7PM3FolA2LBXiDU=;
        b=dTFCSmjJprrbRZVOvVYd9xfP/BLswTsl4/K4WSyFQQPrQm7FsEUQmIvN14G+pxoRao
         CLlenJGzMh3/gsZFRpVmjFf+oCRWLQDn9suztNzfhYVVxBp+FmOY9X+9DbvMiYtyZToS
         HHa011HA8S8WcGgW4VFgbeNu4/5up8JR6n2H5MRbQz0rs5bciIIjMuYeHRlFiuAarYxa
         140lJWo50GH57o9MhG9J9doXEUI+vo+WgwryxWDWTn1dfgZ4/+VzHTeCRkdZp7X95GpZ
         oY94039ul3NIIafxbB9t+Swy6nGZOgYI6qsN7HJxtqILeo0z3JG8FiSYeq0ij78OwYbl
         VNIA==
X-Gm-Message-State: AOJu0YyetUG2yakhByYvrEmut0ixmd9wbW6vOsjaVJ+8Be/r5gZEDoeH
	MHHzjf3KaoUdgUDehctolduM1BkhbTgPjs2Nv0U4f/OFI0B2OVrfpDLY09Dg2TsRTIqnb0UjvrE
	A0O0TL3AdbIu/8D8oeVtLoGsr+OUZbw8=
X-Gm-Gg: ATEYQzz3AcXDcTW7n6DH25ZaHF8J0VOCTSvHpSJ3DhVMF7IUbqnaI1wov6isxuuH3I/
	i4MhfgzByepjbEkt+DpNa/DFKRlemJGXCYzflFqdNsy4VkRzWU7Hy8gHzxTj+xYBTgUmAOGHetF
	sCmjlQPBnO8lPRQSMGnOP2wMLuFz6wUG5vJte6dEC596bTkNhakXjz+9AxrtM5HpwFR5PvFDXIY
	skjIx3a14qPjzRwTz35J5LT1vOqXQlLOBevFHoAwgGW7yKlj6egzuUZCg9W3ChwOu3uo6Wz6VX4
	u0QgwRJoEVAkN4N8NaJXROqk5rJCDHDoAPcPB6T4+InuYainJP/jPru5jQBFnVDpfGxgifPlyM1
	5gFe51W9h7JmaqdP3EdTw/FR8p1M8A3KuKMSjc80=
X-Received: by 2002:a05:7301:2b84:b0:2ba:7d5a:a816 with SMTP id
 5a478bee46e88-2bde1cf86d3mr1483133eec.4.1772360147987; Sun, 01 Mar 2026
 02:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301014811.1712317-1-sashal@kernel.org>
In-Reply-To: <20260301014811.1712317-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 1 Mar 2026 11:15:35 +0100
X-Gm-Features: AaiRm53Mn_sI7CLf0OIDQIbu17GJvtDjkesw-GOEaJbDV6oPCitKioYLXDIX7SM
Message-ID: <CANiq72nDynqELOzEFjf9sqhQ9deoVrH3ZiF=A6Tw1L+dKu1Kdg@mail.gmail.com>
Subject: Re: FAILED: Patch "rust: pin-init: replace clippy `expect` with
 `allow`" failed to apply to 6.1-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, lossin@kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222443-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C38181CF16B
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 2:48=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

The Rust version is pinned in 6.1.y, so this is fine:

> Cc: stable@vger.kernel.org # Needed in 6.18.y and later.

Cheers,
Miguel

