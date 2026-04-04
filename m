Return-Path: <stable+bounces-233304-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIJ7FmWa0WnqLgcAu9opvQ
	(envelope-from <stable+bounces-233304-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 01:10:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9F539CD72
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 01:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7E5730063AB
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 23:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358F936998B;
	Sat,  4 Apr 2026 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r79SH2Os"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A73B36B042
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775344224; cv=none; b=ToA/CvK7GNpfK/B2cXUuBzzwror5q9Mrq7MNfspIoPp8gXY8sOY78kT5tdyUOTqquN7S2M1iMyQYlShB3jgB4cC6L80OVhYTuqmAf8gWyS3NNoGqwoMNdVkWMlokBNs1QvfolXf6+YSbkwjA5rouz8c42ZCyrPPf1v0lGCuV43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775344224; c=relaxed/simple;
	bh=CXe6NWtGmgae7vomAcuBTLuO3Wx/AkjmoxsKp7IFwT0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kTpNM/M1wJB/o083TNYXcsV3ESe0oh4O0+w5E1YkTGPXhjLzS5zHShFA1cYCJvGZiMZYvjlKZbx9BGnFBB0y6VG8uKNONP/H2V5aYqwjyAf5G6HeQmJJwBt6TOKZ6IZIQhPTk59B8vwn+b4ewgiHaSQbRPxAHXhhGutmUEFcAak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r79SH2Os; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ef161129bso2351958d50.1
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775344221; x=1775949021; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4FsZioxL2aVxVY/1E/hjnxADTNtSVDk79XAZmktMYU=;
        b=r79SH2OsHswoDgEoTuw4v1UvYajjpW0AuMebUxO44wNsXif6D6i61f3b7NCMulxMfs
         4cnJzYPLI1eGTK5Pf39yxkA/Und4erLeJldlay8QFmU6HnH7xmAq8kpZDi7g97nTMYn+
         bVYvHkVUmJvG6PqOf31J4UJDk2ScX6aE1c7F/dGIpvZEzYPq8PugdlaHurNM0s0Og+zg
         1I9ORh2jnoe0txQr61yXy0TFu6I6WN1LsiHpEJCCQxylI+7t6A+vNBRCTaYhndmiNDtM
         XSSZCmJ+TxPCDzaSCezfF3ZMoIRAqM2Rks1uC89GBtyDS08FT+iFSZp3Xv4i2Q5QPgNR
         CM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775344221; x=1775949021;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4FsZioxL2aVxVY/1E/hjnxADTNtSVDk79XAZmktMYU=;
        b=L9fUO73PPcO08xqEnOxCAvmPwTmetmAFA0FanRRhm5aRa7qFTUVvLNUdB2rN6lBbOL
         e/LRl3l+031h1EYdRHrK/oLWw4IwCMDENIbrnUpNcqLucO6jkG3+YAH7xhQVBVkbJ9QH
         rFAFDcwbyQ+HOcKNJ2wP0nNYK1LWUar9cKk7+1Z2M6+cg30pZ5uw4xqpJMwZy3sA5ZUQ
         U8eyjur++havUyYbYL3SseUJt9mpX8cLKaGadsH6VeqH/IbwQFs/eFKcwRAh+p/e6lLH
         nXW45dhiMTLm7UiG1YarxolSEBlRrpSorRRgwFPtXWLugLtYFD52GO20ujQV8xphjS8P
         TbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6D4wFEbqF2/PD0k+5kSo6Zx+Lvvcn/Vt8uNnyWuEBOHhdPfImIROGWyaJUVWfbojsAYQ1fdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJjvFMbeRbLdmushw87Sl0U38wKpbMTEhfDg+wC+yUtL9kugNC
	59TUPYMTd5JMm8hdXOb7Ofa2B5Fy3F3XAYB1/kCMjQYoDaHGbibi+6rXz22wSLee
X-Gm-Gg: AeBDievk+3HMqAHZZAiovTurJbqRvefbye+JFHOdVq+E7c8Uj7ET2Y68QENA06so5Q8
	VQy9S7B7bapqXEF0+wUlYVr4VMvcx31zuEZF+Ba+g6dWkrHXyPBy/mNP2mvYYz05WgIsJTzfvSy
	Gh9EQvuUmTmbV1oUYR7II5re6EQ161frkki8Cvl949E7t1AQC9tycWSHYDRxkzVJLd75MITj1Bk
	njf6TMcIFvqZowaBsvFwC6AJuijbY4j1Tnb5908Hs7mncBItoZXfWahz/Ckch5wgxz/89D/+k4r
	mtXMIVU1YEVECraUjk0y/4uPczsEPYbjKwHKTm7Hoj4XEoALSEOtiMmW5f9dUBg6aIl+GRMejPd
	JCHpkbE3g/HypbPQSp3Lbw0oZFMyxItfdSASlHQ7Wex0zDMP8A4BQijeGZbr341O8FEu2ONSKU/
	HRqKLVX91svH72jvMCwUAt/3yfuOL4Ysqt5XKf9TR6e7zvNw/LQ8MSDZeVd/3FBisxU8aqDaoRk
	FdsXLByvLQaE4nLQhwDNn2T37n4tIy2
X-Received: by 2002:a05:690e:1246:b0:64a:dbe3:fab7 with SMTP id 956f58d0204a3-650486859edmr6868291d50.8.1775344221123;
        Sat, 04 Apr 2026 16:10:21 -0700 (PDT)
Received: from localhost ([2601:7c0:c37e:2360::17e2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a73d18fsm4031828d50.0.2026.04.04.16.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 16:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 18:10:18 -0500
Message-Id: <DHKR02R3ZA5Q.3GR6H9I5F3J4Y@gmail.com>
Cc: <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8723bs: fix out-of-bounds reads in IE
 parsing functions
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Delene Tchio Romuald" <delenetchior1@gmail.com>,
 <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260404223144.59168-1-delenetchior1@gmail.com>
In-Reply-To: <20260404223144.59168-1-delenetchior1@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233304-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF9F539CD72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat Apr 4, 2026 at 5:31 PM CDT, Delene Tchio Romuald wrote:
> The IE parsing loops in rtw_get_wapi_ie(), rtw_get_sec_ie(), and
> rtw_get_wps_ie() check only that the element ID byte is within bounds
> (cnt < in_len), but then immediately access the length byte at
> in_ie[cnt+1] and data bytes at in_ie[cnt+2] and beyond without
> verifying that these offsets are within the buffer.
>
> A malicious access point can send beacon or probe response frames with
> truncated Information Elements, triggering out-of-bounds reads on
> kernel heap memory. No authentication is required.
>
> Add two bounds checks to each function:
>  - Ensure at least 2 bytes remain for the IE header (cnt + 1 < in_len)
>  - Validate the full IE fits in the buffer before accessing its data
>    (cnt + 2 + ie_len <=3D in_len)
>
> Cc: stable@vger.kernel.org

You'd want a proper fixes tag if this is a actual bug.

> Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
> ---

This doesn't apply to staging-next.

Thanks,

ET

