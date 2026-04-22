Return-Path: <stable+bounces-240368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF9nOeAA6Wl5SgIAu9opvQ
	(envelope-from <stable+bounces-240368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:09:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5714492C6
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D18F3016246
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9B382F07;
	Wed, 22 Apr 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTBMtIYC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA687383C85
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877494; cv=none; b=OqtJlr704bXAS9vMLnBY55OjgOWWwfVbPae3g+htS/YxLXZHMoXWMr50vwGXv/JWav96N5BV9x9aHQb+EM3ZvNxl/VVsOwdgYPCQEe+tk7afpRu8Wvk+2czy3zPB6KbKyQOgvKFbgkHZH9TnGC4MwN8/M0bloXymu0UTY5jPk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877494; c=relaxed/simple;
	bh=wxRogsKDIsoJB6Ejik8bx1NvCJ1Ic3LbqgNvDi3FMgQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=k8Qhc0sc/PkIPuCjtB+hiU28nThIszXeMYQZN5Oe84gOKJyL2RInjmBakh09/ddbnPV21+vFYt+USs3LEBR/jH1r+WUDP3qmFIJR7OI+yhnQATl3DYQf0JgZ+Gt1wO/phm/IjDlbYKuW6ZCFdtoYrXvcoxJ+5w3UxtxTceJy0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTBMtIYC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d572f7437so3807293f8f.1
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776877491; x=1777482291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+1GBySnBtUImPxIEZErCoyczLirxpWSG/4UwkhhzXE=;
        b=hTBMtIYCi/LnQ3hOy3efrlekPADe01nDcYvGyDxsarNLxAAMgUE9UJpw4cXvFzJipw
         bzrnVJV09Tcb8IMdfSAUhO3UlHUW0vgyjDjmY8mRyINfHBPaMn/MAWEqNd/h/OI+07Ym
         sQxbcTwb5U8wKWB4MwFW4jRCSey+1MhuwJoUj1TcRG9kY5xCPvEWUKGaggd88KPtpT1Y
         P+VU4mNwNLSSl9NbmCEe784IvCyOFlMGKqj41u9wxSs8kzVztrxZMk1Y00h/Da1qmE0d
         vDiW/7U/2kMpvAw+rTUzDJ50ldh6Ue0GaGKum3zF4hb0bY+3VPXGc7gbGDRTRrtftnv2
         SoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776877491; x=1777482291;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+1GBySnBtUImPxIEZErCoyczLirxpWSG/4UwkhhzXE=;
        b=QgOwkoxue9RG094GdyVAnIioNKRuqNVwdYU1CjcfvS5rx3dRm0hiGTTCP8/xq9TjCB
         TaDqIYEdXw/V7hZ7XjuHQ2lZnfvkhmhQNf4wokshfsZLi2qp8JMj/lG9rkAk+Ff7ZVCO
         HjrmrqfUxvjjsGe7x5WQkTS5Y8th+kqLFAElVWwCVgwpxSibtiHULn6oUujDSMw34aEy
         ZQvgaExHjpHPZkVsB7xhZT+mnrTO6hOQCwVSUuOC4OiFk43u8RnahcbTtXduXJxWUJz2
         d6U79dsw8KR/Ekc5p64q8ZwPetDv2QGRiCEkSpGBi1zUsyv/VH7w2fApya/5wbFm4Wu+
         BmuQ==
X-Gm-Message-State: AOJu0YxeL++sQ4orCDgbIge8DFIttkPajwjQtEXmM2i/CCNlM0Z78Z/z
	AyjxymC9imQVF2c0LhSB39DZlrPdLvB6jT3X32+mIpRD9t0ZSoqaGgrmUijt4mJf2Wo=
X-Gm-Gg: AeBDievvJ+zgJGp7QvP2YRxmqWjEAJE7RQH9JxoPoNSG41K9+hR2uh2Mmlsb4U4bg3A
	8lGzJYl6eToLly/62KbCk19dz8MocvaI7Sho8ob2elO1/UPqxLs+mtcUfASD6WUdRugRBI+9tPb
	fLe9S0RQu6bK/Ov1FGkX9mAYaRJagrCweCWd1khXa82/ofJsykaN4B2bfpLiv/efls8C3ltKgzt
	PuWlagWD7CG7iiNyehgC5+g2F2jrSkBgAl+mbGDgKsMyTzcH8m4qPW9PocwJax+5HtBQcLwGv85
	Ch//FYn+xYgij4++jpaAg8qwAyHsxMm5WStFNpWnr+anD2ML+AbMiaAuiCKbaG4y6LO1SwoJfIZ
	ZPh1k9o6W93MIhHUUNJuGeI80kfYeLgAKXLnxYaZowCZKQageJKfYSw4H60bi7Rj2B5yE9E0yGD
	ubYHZ+cNGOd1ExjTmL9GeVDHzl8qOt1G0pTaq9
X-Received: by 2002:a05:6000:2212:b0:43d:7868:21e5 with SMTP id ffacd0b85a97d-43fe3dcbee2mr36155291f8f.12.1776877490684;
        Wed, 22 Apr 2026 10:04:50 -0700 (PDT)
Received: from ehlo.thunderbird.net ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb11b4sm47818545f8f.2.2026.04.22.10.04.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 10:04:50 -0700 (PDT)
Date: Wed, 22 Apr 2026 18:04:50 +0100
From: Josh Law <joshlaw48@gmail.com>
To: stable@vger.kernel.org
Subject: Backport request
Message-ID: <C9577A36-B531-4480-BEA5-42F660C184CA@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240368-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshlaw48@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F5714492C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello, I would like backports for 

Mainline hashes:

https://github.com/torvalds/linux/commit/8cdf30813ea8ce881cecc08664144416dbdb3e16

https://github.com/torvalds/linux/commit/9003ec6f7f394943880618737d797a9f257e6e1e

No idea why it isn't on kernel.org git trees, Linus merged that PR...

Thanks!




