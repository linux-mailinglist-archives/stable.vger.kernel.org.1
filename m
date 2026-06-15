Return-Path: <stable+bounces-263389-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G1duElMmMGrQOwUAu9opvQ
	(envelope-from <stable+bounces-263389-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:20:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B88688469
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:20:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.s=20251104 header.b="GNo3F/Lw";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263389-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263389-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F26FB307EB9E
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ABF425CE7;
	Mon, 15 Jun 2026 16:11:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCBD423A74
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:11:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539883; cv=none; b=HxrsTnTTMCEXFZNgav9n8Q7o29n9e504SdZyVsyG0P6oQF7uxVPBoKDiG/LQvuhnPNBWRtBJXWJ2siBx2o66upk+dBj1ORrA2MX522SSKqeRJIK1zwrpYqBaMZ/K3It7jd5nQk8e7Eyf1qLR9ykURF7XlPGoOhUzG9TlX1J3ock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539883; c=relaxed/simple;
	bh=v+O+yppkseenWDZs1JbF/AaLknmY2AN0YpoReeQBaRo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rpOsqaj3ORE7C71xXxinYZzcdrDbW0kYzrtzHze04NfxVBP9G5/z9TKaunaLFwF3QSAuW0Ga0DBtn8h4mWoZyTd5uXaX8sqZMNvxQQCXqR/la/c0iv8RAYTfa425kPnEJQDQgOLcPXL8Eow4/lcD0IPFQh/n8bfyyM1jZHhdNxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=GNo3F/Lw; arc=none smtp.client-ip=209.85.210.41
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6e9408e30so2257161a34.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781539880; x=1782144680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj7icUEMs4GIx/u6FWTf4aEg63YvIWSyt4xXxioMfP0=;
        b=GNo3F/Lwc8eWmcjX/yyBDPRLHwjBOnNzqbt0sItdN9OGWbppMkV8YclwQU9W5KAn9v
         HA6+fWB+gUBaTLZPfVWxZ/9h4GkmY5FVSUP7oUb/FS1MlJi6N1Hff9TmU1L8lP6y0WpS
         gsPnNarH8cegM0/A3u4OphUHpZ1FZi5XN4tVYkPvOPgo1FSxzmDG1g9/XiEXKLi6jVXd
         2yW5zsA005RglNBPoSz5lIGCJxYQ2l24imDJrrGWFYPrPfhYWBD7fTl8q2tHwGgryk76
         PuCPBb8XT43UqQ0eCRkqIByTbnuwuQ3ux9NpAml8VEWEigNc3DVxH8I31jc9H3AEA0kj
         7AYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781539880; x=1782144680;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qj7icUEMs4GIx/u6FWTf4aEg63YvIWSyt4xXxioMfP0=;
        b=N33GIaNdy5oOAsxUZvKGESTTrGBQIpDBImCBhdYC4YD7whAHMxfelrjh9wfr8+a0XH
         tWAshwFsZhMpR+CTB9DAOZNoRVqNpEmG690zVDuoZIz78AquceJnkNmiRjRZmhLMhF+6
         UNXw6sIFrCCdz7iA5GxB33Dk28iyBaO96HYWopjCyifHT/dHElD2VwXBqweg1PkT/cxj
         ti2SW8gjCDBrAmh2e3qxmWAK7O+Kb4feEzVGs8k8pOs1taYDlLpvvCCVvQKiz6TLdTrM
         wxl8vAGyb54JJNCsDd6lD0l2PLfkDflg12u3V0N5khnrSbdLcWmAo2l5ewQA8DPj/GJl
         gj6A==
X-Forwarded-Encrypted: i=1; AFNElJ8aUgd1qxtFrox781gFvalDeTCcfXViiwtg+ULKOFx/ejfUuThMMhm4mKYNi2ZTmL9sgh9Xrt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZDoBOqIaMyvu8ZwB6d+ZBZe1YTiStzeirjsZNv822tfh6+4S
	tVasf3ya3+79rJBCRjN1NIv2s+dEdS/1Xpn0YuItI5uXNBC9UBdttMqqZdDRNSOAAKs=
X-Gm-Gg: Acq92OEwmhZP8Qg0svMweu503BpBJtmX5Zk9TpCM6BeheBKmFzQT9CzJsH1XTQTyYev
	PGvJgVP2Q9VG6Nw3vsy6pKE9qkAr8eWnOEiS3WWWOxd5IuXhUSEt4iy/9WsbMoF4+DCrIZBt5gp
	i0bFbDSzjLwdlMIKoZbwGwIZy9FIClNoQUY5tW4hxaj518ekNm5SW0ZEfrcML9DDf2gtBbSSKJe
	iCL2EyriiLeUkfY1+cpJ5X+txyQzP4zrXrIo02X7+ura2AvuSQo1s41h2hr3k2zmJUjv6EjFAAH
	7D/gK0VE2dPbit0tK6mbTzMatdnZThNv5KMlPRDoluFfG3jnnGgY0COxTr89V/pJETr8XrxT5+4
	s3wIEze4SksU9ikiaRfgqgkOhE1tP3jvqWYYeXQIXmgOlINiGAG13JR8egChgN3jWv8PywfvOs8
	9lqmq4Tm9UmegmLnDMp2yn6SbC0zRLksjEFfO2mV4+VNAZ/YBwXzLXbtqjkH0yEiokD0JgASxPI
	VAVvPAoz571Xw==
X-Received: by 2002:a05:6830:f90:b0:7e6:f7fb:967f with SMTP id 46e09a7af769-7e78e628c3fmr8131058a34.2.1781539880593;
        Mon, 15 Jun 2026 09:11:20 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6fb5edsm4581811a34.26.2026.06.15.09.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:11:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Michael Wigham <michael@wigham.net>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260613225240.34032-1-michael@wigham.net>
References: <20260613225240.34032-1-michael@wigham.net>
Subject: Re: [PATCH] io_uring/rw: preserve partial result for iopoll
Message-Id: <178153987932.2073745.6612566060392161190.b4-ty@b4>
Date: Mon, 15 Jun 2026 10:11:19 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael@wigham.net,m:asml.silence@gmail.com,m:io-uring@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[kernel.dk];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-263389-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kernel.dk:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1B88688469


On Sat, 13 Jun 2026 23:52:16 +0100, Michael Wigham wrote:
> A partial read will store the completed byte count in io->bytes_done.
> The regular completion path applies io_fixup_rw_res() so that, when the
> following operation reaches EOF, the number of bytes already read is
> returned.
> 
> The iopoll completion path does not apply this fixup to the return value
> and can return zero instead.
> 
> [...]

Applied, thanks!

[1/1] io_uring/rw: preserve partial result for iopoll
      commit: 15a90c358c33871eec14588d4c72b548b4f679b2

Best regards,
-- 
Jens Axboe




