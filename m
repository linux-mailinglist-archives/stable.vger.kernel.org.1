Return-Path: <stable+bounces-230419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEUYMODKxGmA3wQAu9opvQ
	(envelope-from <stable+bounces-230419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 06:57:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F32B32F8C5
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 06:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17B60301DD9F
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 05:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18282264A3;
	Thu, 26 Mar 2026 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI5PnyBC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752813009F2
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774504668; cv=none; b=cLSNnClWb+r06pORTSjGLPrDHrylvAC38TasHliqI82PAfDe3YmnQVFtxmTrh9wWOkFFp3a62cc4dyK46In932wVJjl6TZIzWPhcFIuLiRVHkILJahtOQnEFgFzL7sObrvDfc0y92v1ZBAnpiqXuiE8oJPkpBIy+h5mIQuPZBXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774504668; c=relaxed/simple;
	bh=eGwkqUcQbKDZZG6/9F9PQQadBul6X9JhHH4znZQGFpE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ntSlRwmipdaFPNmIi7/cO35gC852ZKuyfBuw/AMVllyd44utWJkEMzFieH02mXJc7I9W1u9FG5f8eKmH5iAXn0MbJU3WMDeU/Z+w4fPRMmKRAV7q6kcw1fUWjz+vgQ1Mrb9gDROXzP0f4CYIEe8LKX0/0V4ZemcoofbvwlUNMJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI5PnyBC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a9296b3926so3492015ad.1
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 22:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774504667; x=1775109467; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eGwkqUcQbKDZZG6/9F9PQQadBul6X9JhHH4znZQGFpE=;
        b=XI5PnyBC72LXWQBnmQvPuQxKDxpTzxKuAurZWPww5n5f1RgNZaTpTXcHzhxMN4Dckx
         XUtTLRMq8GwS0s4/zXNoQExUS1NQF7E3EshnanroJMScd/FKUzRdQbsuA0rxJ+zX0bj3
         vVU99WErMB5RjlsccmlG7Idyqpp4JQYSzSGBQFB8Ex19x67zSvUNRDy5nVicdFX/PZAx
         AKIZELXF2YJxE5cLOOdLs5FNpE+omtCkDvFqsuiojnTPXLIh1GThN+xQsD1HTIHulG4N
         ibu44C5QYodFBk7H0aneyJYBS0GZ/yiAZLnmiwnGJktTz39HIfDVg0T5nHgNUmbod55I
         gr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774504667; x=1775109467;
        h=references:in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGwkqUcQbKDZZG6/9F9PQQadBul6X9JhHH4znZQGFpE=;
        b=NczQiRHcuH4SPJE//XguM1Wp1Ak5SbPd6VrZpoz2FfLYCl1SHycwbNPxU9WCmf5Q1Q
         JgsLucT/ax4EbDUCwoQSWZ3ttUqSDIBD5LYc3X4dczmbrDdaoiSVgifaqr2b43/LM9dB
         80jgwVrssuR0WvLGUzq8dRT7GWoBn0phKRGnnVKG+Ykqqq9EWY+I19MCC5KJisDu/aIn
         b8vyRIYxDSE0dIEx84dplZPwWFK4M2+SkAGyyCZjBOgEacSph1KCs5nUtqRX27J7PZLo
         Haj1NZDrx0wixLS+F9cJ8hJR18ZZQtEVlEA2SheJbA6fQRfnDM+3hkFHDBcYL7J4OexV
         nmCg==
X-Forwarded-Encrypted: i=1; AJvYcCXiJmTxCqcgudefDJ+q5B3GTKXuAol4Difo0o9VtchsrKwFXDfPwia7nb/IK0HOuWy1HAQgYic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXQgAqkg5lYB+T8QMLfarFZD7HH4SBjgzJCQp0sH16JRXSn27d
	YxAD0suldiBjmn/XYb6djynSInM7uM2sH+BoE8VXhaymRKtv3NA0dLc/
X-Gm-Gg: ATEYQzzcibymbd4OHPtjgzUy33KlyXFVTtyco86NFhIEhzRt1+8KZuPI78WzagntcI1
	eNidrXUQndph5L8QOG6C0F+3rBGUcZYi8ZblB+HjCr4Amx3EynB33JqqUuU9GxWFjhwgs6rQ2Y6
	4IVteONOoNqpvrxsQmiJVSl7Tqi4mptMvsG2lbuuOXFt8G1s2YwwRpgU+rvbOjm8OVpNsMlTFJB
	epJEhF9Nki3fNRgw7BWCJ9D/LCPbFDwZybH73br5nIUHylRoXzq2H8ML7WG+/ykuWF3rio1FU/p
	pdx7fgLDINR9tHGGqQkPcBMfm36PUqiabaQwuXzI+5rapGQm7KpO4GzzBQaiOrC6yeCzWRVMzI0
	B97gJComP9+S/cjeoVHdPwSKHWX6BsmBTW+icIQTcHdwRyYOpReCP8IYBdg/5pxaT3FOnSDg69k
	Ten4VzYKimQjWCa+6lMQx6Ynbv7wK3
X-Received: by 2002:a17:903:2292:b0:2b0:61d9:77ac with SMTP id d9443c01a7336-2b0b0a15977mr65774345ad.18.1774504666871;
        Wed, 25 Mar 2026 22:57:46 -0700 (PDT)
Received: from localhost ([240b:10:ff26:df00:3001:9be6:4399:d681])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8bb5fasm17437975ad.59.2026.03.25.22.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:57:46 -0700 (PDT)
Date: Thu, 26 Mar 2026 14:57:41 +0900
Message-ID: <0328d0852f0a27d625e1bc629a4ccea9@gmail.com>
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] xfrm: clear trailing padding in build_polexpire()
In-Reply-To: <20260325171532.GI111839@horms.kernel.org>
References: <20260325171532.GI111839@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230419-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yasuakitorimaru@gmail.com,stable@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3F32B32F8C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 27 Mar 2026, Simon Horman wrote:
> I think the Fixes tag should cite the patch that introduced the bug. The
> commit cited above looks like a related fix, but no the cause of the bug.

You're right. build_polexpire() has existed since the initial
import (1da177e4c3f4), so the padding has been uninitialized from
the beginning. Sending v3 with the corrected Fixes tag.

