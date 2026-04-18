Return-Path: <stable+bounces-238545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOqIGGYk42naCQEAu9opvQ
	(envelope-from <stable+bounces-238545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:27:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB1420295
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37311300A336
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 06:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3187033CE80;
	Sat, 18 Apr 2026 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWPufbQY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96771B78F3
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776493668; cv=none; b=Ou24WWVpIO/KuxyvEDrBl+CGahIhjVGdspc8fdN4VAcwSlGCYwmnidHNTWCOV77yejbkwX9dAIFdPFA52/l3WDMDoPTtd8bZvbgm64AmnYjciCMBkbtqq8k9t4aehtxZxMbJ1MaomTLDH3TWmfTveEHqhOg8kX5HkxHY4GWpir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776493668; c=relaxed/simple;
	bh=ZaerADTX/9d4OB6JOKneY9A3Ipvi5okc/UzHhhduIrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayKj4ZUCRKRdSdu4hU4IL7FcfM3HDXuOFYgpv7Lp5MnYoJExPZY8PzZQ5lCuWwr74Kt+SfUgcvYtO6DnHY5J2QIyifaKvKXI57q1Sx29azkCqX6Qq9580OBzVWVOOPr48uFuxE30pBcOU6TmWlSX0jxKBlDEHY4kOEx0CV0CaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWPufbQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BB7C2BCB7
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776493667;
	bh=ZaerADTX/9d4OB6JOKneY9A3Ipvi5okc/UzHhhduIrM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hWPufbQYbahgx9ShN6EJRZNfYlle1cX300BT+Ef4lRki4IIQ/S/D2hImt2Uzxx8fZ
	 rPhL4r039BrdqyPbmvYYLeb+h8Z8qOYE/6SLvY36iHhVmwCexzFP9ujpNAfLHSS1wE
	 l/xkMHAYynjeueuKrC2dE04n7EdPyjsXPd1Y+wtR/G/K6oph8VvElMFlQP+/dme8vp
	 k19k/2iHETN5eYmw9afDRmYA845Bw6VFRFITmzqgUjG+qxMxANTeD7ioCGpDGLcge6
	 u2l9daFIr5WwHrtFSCW2lyAHzs6qpY2sD67j9NHbv+ilBtZmCbMIertXm+h6Wac7lO
	 jf9qtSju5w4fA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so205390566b.2
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 23:27:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ97L0DqOxSVjI6xxzhE1YKLvEvxZ9M8L7OBsto+sba5HBBgCV3VbHz93VnbQrKtwvQOuB3/WM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhmvEfFMyDcTXl9zWWbqH6kVXX+8O/uatQRKMh7WPbgRuZKD0R
	y5St7rBxaei4vHOAsEfqxXtVnQPtMbdeQ76CDPF33O4SS9xlL3ho26cRsKYaH7bw/xpuOvrQsCo
	ebkkkLO5xYOTAutmYSaCSFO1PmUV2WXs=
X-Received: by 2002:a17:907:3f27:b0:ba4:e5e5:58b4 with SMTP id
 a640c23a62f3a-ba4e5e55b50mr193236166b.20.1776493666380; Fri, 17 Apr 2026
 23:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417195457.395596-1-tristan@talencesecurity.com>
In-Reply-To: <20260417195457.395596-1-tristan@talencesecurity.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 18 Apr 2026 15:27:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_Eca1+NaWf9Ozw=f7Y60zyFy782zP3fy9KNVGWSBZuVg@mail.gmail.com>
X-Gm-Features: AQROBzCN5Z9kXydzRfYU07c8UveZxFGstUlR7gWYKQ47Q3I5Gd0ZNvoaQbPYpvs
Message-ID: <CAKYAXd_Eca1+NaWf9Ozw=f7Y60zyFy782zP3fy9KNVGWSBZuVg@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: use check_add_overflow() to prevent u16 DACL
 size overflow
To: Tristan Madani <tristmd@gmail.com>
Cc: security@kernel.org, Steve French <smfrench@gmail.com>, 
	Tristan Madani <tristan@talencesecurity.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,talencesecurity.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238545-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: E3BB1420295
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 4:55=E2=80=AFAM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> set_posix_acl_entries_dacl() and set_ntacl_dacl() accumulate ACE sizes
> in u16 variables. When a file has many POSIX ACL entries, the
> accumulated size can wrap past 65535, causing the pointer arithmetic
> (char *)pndace + *size to land within already-written ACEs. Subsequent
> writes then overwrite earlier entries, and pndacl->size gets a
> truncated value.
>
> Use check_add_overflow() at each accumulation point to detect the
> wrap before it corrupts the buffer, consistent with existing
> check_mul_overflow() usage elsewhere in smbacl.c.
>
> Cc: stable@vger.kernel.org
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Applied it to #ksmbd-for-next-next.
Thanks!

