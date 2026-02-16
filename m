Return-Path: <stable+bounces-216717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP7JAfs3k2mV2gEAu9opvQ
	(envelope-from <stable+bounces-216717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:30:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AC2145991
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C29A30062EB
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FC42EC57F;
	Mon, 16 Feb 2026 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DQZCDuta"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340AD1EEA31
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255799; cv=none; b=E/y6CX/YW6D5mekZtXjpxAYV/BAN8QDLqa0dklwrcvBnjFM9gruapLT0eX9pRtzfL+l6IylAR01I9WgmJ5P9zDVcfnscATH2gnlCut/k7kwD5sBjZZN7vDoVpC/jNan/V0ryMecsp8SWqMWh70Aj2FvvC6MnG0g0cYs/QrZi9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255799; c=relaxed/simple;
	bh=MWM6DbuJEwYXQIuHcyvn6XjWfxOTdzD44c8RDE7eyQk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LpGNoYAqpy5Llm7HRxGfLcMiUAf4t8ijFe5dQonMQw3MLKKNr5jtYd42aApDkFLxc8HiIqcFRIcMezObSADpVtecl1AIiIrRB5K6imjvv4Q2hd4NJ48wfBdCtAjQ2Xi41gmZPzRL3bqupeIihuikiRVAhvDEdrlybkyxcK2SAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DQZCDuta; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-662fe3ff6f6so1523730eaf.0
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 07:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771255797; x=1771860597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8N8W9m+TqdQtO25+aXT/RZHv/2DZcyL0+Fk8m1ITjs=;
        b=DQZCDutaut71YX4cg/078z7ORgvaJB66kXJnDh80aZZAGczByjNvAKaOt6ZxugrJTR
         Y7TWnm/768XEIUKC++k/aZ+2yDqU9wlWSEO+CmvBi64Pl1D2DGORpgIgynbfnk9eUMqm
         V+9KsGP+029PDPmpuv6Qln/8MNCi9n6kETe48rIBzh3kW/EuRwJ/HaKPvdRz9CH1UEnI
         sPku9XB/aOWiteoPKVZUXTMrTBx/ddC4TnIG/+Dztrmy5jL+S9uvPaeQllw9yjdbnsfg
         A/eZDF2i1CYIX12IlADQXrF3CmPB+4BBOn7eLtgncizDMeQahAU8EcEhHsez/D+UfpU0
         rx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255797; x=1771860597;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w8N8W9m+TqdQtO25+aXT/RZHv/2DZcyL0+Fk8m1ITjs=;
        b=tN/TfLINUvKQJwTDz+qSv0YLkiEw9JCJcHAjbEe4CtHRRew3qKTCKRmTf9u4ZDTsUN
         q9MmIp+oufPvoSHsdG4mwqqe9h9tsWeCbHezSMgiF5zUIsgorhWLI2G2lI3Vnu1FXBVc
         soAK2ppjxLtQyRBuP2sNEH6VxcTBKeiZ+V21aySYYRDsaa5EtIEpD9aL/soOqvo6/rVz
         0b2AydL5EZOzM2WBmDL5qco4xbWg/nHn9OZH9HrU1zKCQGhWQTQawLQ04hSjrv4GZ3wR
         TnZ3MEjOGD2onNJfKWqYxjX+V+04RT5s02aU0A0bCTtTupo4ja7yG9x0O8fDVMu5YL7b
         pJKg==
X-Forwarded-Encrypted: i=1; AJvYcCWHzpnVUqRsSb3jho85OrZjj3JcudKufcp0G2qN5AlFlyqYVTX9CCovldTnB35WLPD9ANGHsyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiXJl7hD5mKxVrHZkqpwKp8KT0+bCcex9gqdWQFDhzBuLvXYF
	JmdFomy6pRdfXi+I9yqYkV0lrGYVuMJNaJ/bcHxnBTJRmWqfTHjSdq52DP8s3KmpUX0=
X-Gm-Gg: AZuq6aIdg4M3BdhJ9yzK8+12Ldq1CyqZ3DKpTN4ZMKvhCbcv1SP910E4P28naZNPBMS
	1ZScYIcKB1QrWbuRc/r9mdacfNSozuMXXzbUkeyV6etf/1q8uFNKFPWdAUD2yAKLhvfXnTp1B0j
	HK2ZiPjgii15PwO1ySAjHXhbZ1zNfLt375gti7TTJIZ4n8T0Bi9eUUd1y6WgDN+L6wh2EdkER7N
	xn7CKKjRuBPQHYn3GGpbOUtull0yslpj+NAeXYjBCkW5AONJfSepuXlpYbnDeR4X2h9azKr2qxp
	x1jHQMiVzZOb/+d7Rsgk3VLmQGJIiDnu2fKQBhVY/e4zmbIukvkFR4Jk5DigkPHqYXfbyih0PnD
	YxMOJdt/ineD+58OpmNrqTlb0f+rlHPzsexZKSlCXJogChjimb5tZDyFg6sUtTm67MrF2rNp5R/
	3RtUKI4rjeIZvQydHVWb4PeVJlBUD+b/iv0VDBiOUi7hXnPu03+F+7hZKYO/YEEEAhFTPcbPdHO
	Vte
X-Received: by 2002:a4a:bc94:0:b0:677:520a:b91a with SMTP id 006d021491bc7-6775219ff33mr4448186eaf.51.1771255797089;
        Mon, 16 Feb 2026 07:29:57 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6777c128a11sm6223317eaf.0.2026.02.16.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:29:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: Breno Leitao <leitao@debian.org>, 
 Gabriel Krisman Bertazi <krisman@suse.de>, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260216-io-uring-fix@fiberby.net>
References: <20260216-io-uring-fix@fiberby.net>
Subject: Re: [PATCH] io_uring/cmd_net: fix too strict requirement on ioctl
Message-Id: <177125579594.125569.3885850915035279276.b4-ty@kernel.dk>
Date: Mon, 16 Feb 2026 08:29:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216717-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21AC2145991
X-Rspamd-Action: no action


On Mon, 16 Feb 2026 10:27:18 +0000, Asbjørn Sloth Tønnesen wrote:
> Attempting SOCKET_URING_OP_SETSOCKOPT on an AF_NETLINK socket resulted
> in an -EOPNOTSUPP, as AF_NETLINK doesn't have an ioctl in its struct
> proto, but only in struct proto_ops.
> 
> Prior to the blamed commit, io_uring_cmd_sock() only had two cmd_op
> operations, both requiring ioctl, thus the check was warranted.
> 
> [...]

Applied, thanks!

[1/1] io_uring/cmd_net: fix too strict requirement on ioctl
      commit: 600b665b903733bd60334e86031b157cc823ee55

Best regards,
-- 
Jens Axboe




