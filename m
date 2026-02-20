Return-Path: <stable+bounces-217581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMRpGVJrmGn4IAMAu9opvQ
	(envelope-from <stable+bounces-217581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 15:10:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C7716830E
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 15:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 916A6304C134
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4D634C124;
	Fri, 20 Feb 2026 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ucpeUUWD"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AEA34BA24
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596566; cv=none; b=mjia6Xfx0Eyykh6sRQsw6rHsNYzJzpDNQ4X3CcFp6Q6dZ9mjrW1DllQigw9XonWyMEpTmQtTW6bQQLe8lWMpnN04adMEABbVzQmsSoEr4zcSvuw0ZSq+VO4gSuziOHuTX1gbvdNxVFwUUZOj2GBsaVXJxvt90JHc/D+BcBEzsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596566; c=relaxed/simple;
	bh=PTSO/YkUpfmOIn94JPRxGsqH4ok7zfKeQzMGFFqtubM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BM6aZuRvnTo9i/1LjqYNj3PP72e1kPpjbaq3R84sJoSR8wJCmbyCMr4edg+4HE+D/1bMj6SamvihUI5QnyjJCnzaxbqqofS55JlZK3SimsH+xej/m8GMcvF5GIl7T0t89z/OAKUtu/6yypXOnamYZpehkxoyq78FbAkP9+dTcMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ucpeUUWD; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40423dbe98bso883958fac.2
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 06:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771596563; x=1772201363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6agG1a/ZZ7prFDRVGuF7sIP7aaRyumONnsIWUYhmn9E=;
        b=ucpeUUWD6SHvInp4P4AIAVGBCIMfUseDJ6HLstwHHrEZHaWEzx3ZS6XHEEfXEkNCIP
         TTluddkd6QwBDOjtPW8cAory88ZrRsbTdZuh9JRuyXsznJ2hT+Y5toJMyood5phNG+T6
         ZtHU1bgwnpj0yk5lgU5ntynKEvpLswS8eiOlaMCmKxOYbXIg/QVHBfY40iGNXJ3JSUBn
         AqgKsVvzxW616mw5T2QexC0WEZZbx8RbVlWvVw31UICwaupB+NGYUnwwMTe3Pck4EGUm
         oCAgWK+q0R/cWJIzndUwx7IrxZhW3W0OqTgEFY1mikiyDyilAdgSEp8Hj2JE+1QMigVs
         vUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771596563; x=1772201363;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6agG1a/ZZ7prFDRVGuF7sIP7aaRyumONnsIWUYhmn9E=;
        b=ZzIb7Py5yIKW4P3JohFJIFQKia3aC9nKyjgskm5AWT4fAQ5r92UjPKb8/CuwTmIDoK
         0PPDTCaxvZ+pUJKXlLcruYxouMsQ6KSrzw2x0odrvdI2yeh5mcmvFsgNfDm6t2d9vJg/
         yJRVN5lXX4DLIs/HYZ7XhTfYP0brotYph+Q1wg/LNepWbiFiW6Lv5YFLSJY1pr/63eje
         8XdHd0kwLlG/je2KMWbXMFeM2basDtKj9tt4icv+3QwMMZIev/jIl7uRh0Dw9N9ZX3Yg
         wejMKxlnvNwmPVpIhaVG9P+Rrj2v4jn6vbLJClK9HnfQgUI4oN0dp5aWR1QK2tuXGF/u
         G1NA==
X-Forwarded-Encrypted: i=1; AJvYcCXxSIKFa7QbmfA/1qTsh2f+hOSsJjbtIxSSKsLwr0cRETqVWwOTWuI1sls1xl6MH6SFk2MGeSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9u0x2zbFaZ3GhSrZt8WhacnBBuMpbifmSRhunIP+CXCRmqmn
	FnY4H7vH8cd+utqOq5xrMqqsvpIxP1y14kUiLbdAMuoqVxx8dSNHiWQaz0ZDx2c3NyMLcX3wOYL
	BF7zlTNUPYw==
X-Gm-Gg: AZuq6aKjUXs9Ji3bjZ79YLSbiPnd+WvCIwgSnRasRbn6Wd4mM1Llg0iKolMWya+/B7i
	HNdbYxloGQIW0o37WyNA6BszANJrVfzQgEtYQUsBz/duLQB98sL7FUsQXworeaR3Bml0ixVKkxa
	2NZDrfF2Yfee6Ipe+NR9rrCUUqgRfi74bzJW+S4cRgeaZ7AhwJ2R2nQFyMVwxwJN0uUmiHah//l
	sYz+X+dwSBgR6BEI96K3UyI5yPWscbQCNvwnGaWrAtBIV+EEH5bPrMffjboMUVLRFqI5r9Uh8tN
	rEoK/Zu1FIg7bZziQYKfN0DrhDxupk1zJK0/cQpqxnd4O+/dRpPXUa4YeBI2ebbkS4Os35YEVrb
	7F7A6Q2G0c31vpdeRKdEbggaGlSRSCVr/FUXb94gMwqffQNg738nlQARi0gcRAf8H+KmRHUwp3t
	7ulKsdLWV2kocCb75CLECdMb6A+2vqriAlayyA5noG3u/r9p7qtLbeG11ph+iAmrelyNVutIxIZ
	/zUAQ==
X-Received: by 2002:a05:6870:6b0a:b0:40e:dcbd:e92d with SMTP id 586e51a60fabf-40f0d1bbcafmr13285290fac.0.1771596563456;
        Fri, 20 Feb 2026 06:09:23 -0800 (PST)
Received: from [127.0.0.1] ([187.199.77.89])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaeb42708sm27916776fac.0.2026.02.20.06.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 06:09:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
 stable@vger.kernel.org, Tuo Li <islituo@gmail.com>
In-Reply-To: <20260220113937.2691322-1-christoph.boehmwalder@linbit.com>
References: <20260220113937.2691322-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: fix null-pointer dereference on local read error
Message-Id: <177159656185.567740.9381187974299808709.b4-ty@kernel.dk>
Date: Fri, 20 Feb 2026 07:09:21 -0700
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linbit.com,vger.kernel.org,linbit.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-217581-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08C7716830E
X-Rspamd-Action: no action


On Fri, 20 Feb 2026 12:39:37 +0100, Christoph Böhmwalder wrote:
> In drbd_request_endio(), READ_COMPLETED_WITH_ERROR is passed to
> __req_mod() with a NULL peer_device:
> 
>   __req_mod(req, what, NULL, &m);
> 
> The READ_COMPLETED_WITH_ERROR handler then unconditionally passes this
> NULL peer_device to drbd_set_out_of_sync(), which dereferences it,
> causing a null-pointer dereference.
> 
> [...]

Applied, thanks!

[1/1] drbd: fix null-pointer dereference on local read error
      commit: 0d195d3b205ca90db30d70d09d7bb6909aac178f

Best regards,
-- 
Jens Axboe




