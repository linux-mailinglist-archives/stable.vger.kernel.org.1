Return-Path: <stable+bounces-271655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AdtnNHxgR2pUXQAAu9opvQ
	(envelope-from <stable+bounces-271655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 09:10:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3616FF6BB
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 09:10:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GKOCUNTZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271655-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271655-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4463A3054C39
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 07:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3138AC68;
	Fri,  3 Jul 2026 07:06:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7583385D64
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 07:06:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062407; cv=none; b=SCriGh/tLdBk9UkVKUV2YpdeinVI39QNkw9zucqCgLEElC8BdSneVpBdggiZB86gFPs+s5qjoliEDJK/qcDngoUNfFBnuAzkziRsSTXqvLfSW+ey5GSzoK1rkjAKW4fZvNlrJJYoyNoxWoj1z/b5Edqdr1j9e8H+u87P58irDdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062407; c=relaxed/simple;
	bh=MAX584q8Bf9oJv0xG1C3L5CqaK6oWhvBEcxx10I+oEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7N2hoM6KeDzxIxD91a3ImjV2A4dqxAaRsENBRpiFEADcXeOYz+/UNYYKDXRd0q/M1f/YDfTub53SOLbXtkLbnlm4MgJRnCz4+5eaZu2+Gtkjf+aVVkIZ+HyMavBXoxAIOWm3vIqc9EIWTtqx/Lak9wGyznDki2+xeb+Luz5cx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKOCUNTZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9313B1F00A3D
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 07:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783062404;
	bh=MAX584q8Bf9oJv0xG1C3L5CqaK6oWhvBEcxx10I+oEA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GKOCUNTZgKk4Sw22hh3T5pk/MEUarjHvXYGdD+TFH3ce46NeJStJ52QAIhml6l3ZQ
	 pqIpxwKoJYVXB7canjFKReL0t3DbtIT+MmqP+TMB9i8sPQ8f2NZu2HMYT6L81uyPsM
	 SSBdTvGGEFuGeFPnu/J/YZ5vtAk7DrmDGbtFiFr3waKuNQFFrewlAbE6TFOs9+Ksk4
	 E0iLzTQLE17mWU+pQSwxmQBpSybkURHqNDkuPqCFuNW2GT686dyXw+jY38ejaKiENv
	 IRodl1Knuv5I7wAVkusnH7T4iYTEuYkFBApjoxgzYnA2LCdu0FjfPw4X+Hl9686okG
	 /FPKw53V3Owug==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c12629c937eso26374066b.3
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 00:06:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoekMLandF2e5CWRzI+SckKx8rGvt4YA+ud4RwKtRybNzYSnRr+am7ZdwEXeZTeLHwiejBjikg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdg3L/ZvNUnfOXUmkICkXyxaEcRdJyyf5MDe9Q6z2Hn8CjZfX
	ocPm/3YpMZ0aPVHmSUojObOcij9cuPTwcLWRjC+5cJ7D2gFsZbUUxP5pBE86II1ze/uIPJ/q6vX
	u+ArxR2eZhAB55Ktdmc1hYhZu7fjrzes=
X-Received: by 2002:a17:906:3b0b:b0:c0b:f304:d5e9 with SMTP id
 a640c23a62f3a-c12aa1766c8mr318163266b.48.1783062403275; Fri, 03 Jul 2026
 00:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702033656.23048-1-zenghongling@kylinos.cn>
In-Reply-To: <20260702033656.23048-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 3 Jul 2026 16:06:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-2nR9-=O5DYiw6x9R4KpuiV9eqH+HwiYxdAmihw4PvYw@mail.gmail.com>
X-Gm-Features: AVVi8CftQxzb-TjQTWfS9aaHyP6rVkjSuHj_85ulbR1x80mW98lAFqKge9IPlfU
Message-ID: <CAKYAXd-2nR9-=O5DYiw6x9R4KpuiV9eqH+HwiYxdAmihw4PvYw@mail.gmail.com>
Subject: Re: [PATCH] ntfs: validate error codes in check_windows_hibernation_status()
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, charsyam@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,126.com];
	TAGGED_FROM(0.00)[bounces-271655-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:hyc.lee@gmail.com,m:charsyam@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:stable@vger.kernel.org,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E3616FF6BB

On Thu, Jul 2, 2026 at 12:37=E2=80=AFPM Hongling Zeng <zenghongling@kylinos=
.cn> wrote:
>
> check_windows_hibernation_status() calls ntfs_lookup_inode_by_name()
> which returns MFT references read directly from disk (untrusted data).
> The current code extracts error codes via MREF_ERR() without proper
> validation, allowing maliciously crafted NTFS images to trigger
> incorrect error handling.
>
> The MFT reference encoding uses bit 47 as an error indicator, but the
> lower 32 bits can contain arbitrary values. If a malicious image sets
> the error bit with a positive integer (e.g., 1), MREF_ERR() returns
> that positive value. This can cause the function to incorrectly
> interpret the error as "Windows is hibernated" status, potentially
> leading to the filesystem being mounted read-only (denial of service).
>
> Fix by strictly validating error codes: only accept negative values
> in the valid errno range [-MAX_ERRNO, -1]. Convert all other values
> (positive, zero, or out-of-range) to -EIO to indicate disk corruption.
>
> This prevents potential security issues and ensures proper error handling
> for corrupted or malicious NTFS filesystems.
>
> Fixes: 1e9ea7e04472d ("Revert \"fs: Remove NTFS classic\"")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
I think this should be fixed in ntfs_lookup_inode_by_name(), rather
than in the caller.
And I will revert your previous patch ("ntfs: validate error codes
from untrusted disk data").

Thanks.

