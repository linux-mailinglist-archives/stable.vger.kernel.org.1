Return-Path: <stable+bounces-222441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMeOFrgRpGlcWQUAu9opvQ
	(envelope-from <stable+bounces-222441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:15:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B201CF144
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26C0C301C8BA
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 10:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2B3358CF;
	Sun,  1 Mar 2026 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU3mVPob"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11A335562
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360085; cv=pass; b=ZjvXt5hiwHZ6kGGj/b3bW8W+6BZHl7+pgHNttwOglo3L4/GI4OotWaN0/R225IOGmuJPtwACypNUoxN2jE5blYWBsdMqr3l7lyuuUphpI1A1fAD1OBAuC69qLK9zGWDctlUKXP5C9mnjiugs15kuf/xK3S8EiOBda3IOnkcCksQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360085; c=relaxed/simple;
	bh=cjhzWL5snQQRFL2q+0O1SEhe7wxxXvqWru9pPmmmonQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeg4K8yM9tBd2olSjpd4AYH9VvjnlU9PHTAu3yerz605M+RckiBBl3x1fm8XFvh6o2rlCbAImugYHXFkJgPJ1vxrAefH02wCxmJHElGeAtjAjczEMvzMJjyhfKgXwXCuXUKKlHk4zI07YH5nEBbAb0oqbPn15iuFkpzUIJ6DFf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU3mVPob; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b8095668ebso154248eec.2
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 02:14:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360083; cv=none;
        d=google.com; s=arc-20240605;
        b=iSpqibclkDftQJ+hPhLana3tkTf87YGXe23XsOFJ1WsDQFP8s+Hp1CzJMonk2IkTcl
         MdBIT+AUUISkw3uCBcJWydEG5o2rH6YcqxBRlZuIqxoWRvZUb3tIo0W5CirU5h36EMYX
         O0JEU00CYmcJaZpxqyotPqjpzDGAsgGpmKlZ363d/az8JXDv1V2E7OMKYaiRjKKIeKCd
         RxDQ/Z6rgnvzUGx5Pbmj+fE3GPhmqdGDpiJvQIHDooKewqChif7cETqAgoLHopjIwweR
         Bw93+zIZlEqhO2MkLjXwKpetAQT+10ynUctODfTafUk350PvrTobJ8LJbzib3b0ZDZsL
         BQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cjhzWL5snQQRFL2q+0O1SEhe7wxxXvqWru9pPmmmonQ=;
        fh=Me4lvb+0TzIoUKsfdx0+5scFQ0m9HX6KbyTr2oLN9FI=;
        b=Y7hQ5g9GZmt3PBdhAF4sLvW3A9Asm8OcprvRkoGxv90gF0GkZ7WtDuijZAZx9eMOga
         M5ZDFKCQuK5P2aMpjN4fWIf4AWtdY2tGiPnUk6YsXHE6MsxPCp/jKUDy+YbUTtgD0QoO
         AH7zWTPgD2hzbO/7bDehDGkL13VHZPcoCOI33I4j4p0OAv6DsklvHusYL4pBZrJP6/mQ
         S36TDG8UaqLMt7emFTPOOQsSmx1NSNfAE95100WIu6/INYWPrcWvvRmJriFeUoo7Gm+U
         e5/rzN3Oqw6UtBkMwgtLsaMB/DdPgUAWdHc8QxOr/+vM/tXaA/MNVmuDY7MnncFO59TR
         zmpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360083; x=1772964883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjhzWL5snQQRFL2q+0O1SEhe7wxxXvqWru9pPmmmonQ=;
        b=EU3mVPobyNztLU0bvCxiC4uOindkBTwzcybInpFt/twtUFUtJPu/F0v7yGWsCSNlcf
         TliW70KncYpqwGEOormfk0MvWutzy2K9F0LPbDCCPNELxq6IExaArngq8XZ1ulpI6ukh
         qtaFTq50k13LHOUoq7j8Xs8soPuLtxFGbEN8L9zfjTahfUltuRpY+2AAse9/KZ4j2soC
         VUHxMaJJJgnOWJ1itaFZcNI3QDgYS9FslfO0axYiPhJrWZh3ue8riaGcJx1aZS/d7rVc
         DUkI63JCVADBOkZLGYvnW/mPH/6Al40Plefu8lahNwNCOu+wps66bF2Jz1vaL9XbibUx
         9gGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360083; x=1772964883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjhzWL5snQQRFL2q+0O1SEhe7wxxXvqWru9pPmmmonQ=;
        b=XnN9efG4FvGf8YFCNIlNW4cRTmua/oydlVGM8l9uEhuajFXk+U6JiLhfgDtcKhm4M1
         4dXKO+Q87nfpK1MD/0ZCY1N/74srbPXEoYXtBYAccoKi2mbo9ib/NHDPh9H+iVBLGcxj
         7RaIYfb0RIVYx8XV+zafieCTMkI87D6wRgCPmXv097wFtjxbpO2vLRCK1ntWfGAhOALl
         58EkC+wfTwLI7Vx8Grt+DV+P2O9vU2d4p6Tv77BuXWxvzjj0MWJxDU8zZu1DyFvW1aRk
         LZbrcoT67aOwKt0WhWASfB2NpyEku21FiR08bAhbkO3gmQY8vgB19/vK4DUDLTJQJ9p9
         b0mQ==
X-Gm-Message-State: AOJu0YzsXjA/WjQAnKWKEnNoDagm4imYaMWWqsimzx75yjz4YU/eZtca
	8pO4BfIqKJdnIgNwJ+9uZIsuLeeInni14Oeu8HVJM6gl7Av4ZBdNI7t7xyYr7Crycs8yeDRCU/h
	2wb9eB4SYJSkbdMABBf09IVbmmxKT8Fo=
X-Gm-Gg: ATEYQzxTOrT7+mL0OvjDRO66VO836IoMhGvrXjH471xAhOw8Ve9vGaZi5AVYYbovXz5
	eOnyP0goLTeDoLIMAeXId71IncFoKnTCVZ1GQNoNSDttKvByz+ukZhwo5DIcsBFohdcbgWXthbQ
	6qejREJSyblvfX0yGKnGU2yvlyIh/fmX7/lZZKZ/W7TpYO51ZOq0pyO8KB92614kZDkjyLoGhTU
	Kc2eYNNoT9mnU7md3OyoC4u2KmBiv3rr1ztAvwWytlk6ElLrYJnmsPGYLtN4ISDxhu/VsSo9z4d
	LrvHP5GQRbX1cCnZoAPOK73289tF2MUKvNkFPSdg25srZbgDfvSVguYqNRKCevrq+G93rRzMi5a
	/z9EotAftI7m81/YfgzcsYfmBE0Fd
X-Received: by 2002:a05:7301:169b:b0:2bd:dd46:7a55 with SMTP id
 5a478bee46e88-2bde1b29395mr1334733eec.2.1772360083179; Sun, 01 Mar 2026
 02:14:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301020433.1733030-1-sashal@kernel.org>
In-Reply-To: <20260301020433.1733030-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 1 Mar 2026 11:14:29 +0100
X-Gm-Features: AaiRm50Hlf9gIQfF7fQuV2aKb_-jNfTn1wuMZssAzS5fSsnh7bRKgXAfVYcviPc
Message-ID: <CANiq72m0pCdR3dijUiK2Qt-NDV7K-UMcu-HEakPh32otoGMevA@mail.gmail.com>
Subject: Re: FAILED: Patch "rust: kbuild: pass `-Zunstable-options` for Rust
 1.95.0" failed to apply to 5.10-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, ojeda@kernel.org, David Wood <david@davidtw.co>, 
	Wesley Wiser <wwiser@gmail.com>, Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222441-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davidtw.co,gmail.com,garyguo.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B5B201CF144
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 3:04=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

There is no Rust in 5.10.y, so this is fine:

> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).

Cheers,
Miguel

