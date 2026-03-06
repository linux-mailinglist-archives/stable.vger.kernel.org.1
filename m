Return-Path: <stable+bounces-223289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGl2G+AkqmkPMAEAu9opvQ
	(envelope-from <stable+bounces-223289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 01:50:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0E6219FF5
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 01:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 307ED3036ECE
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 00:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956952EBB9E;
	Fri,  6 Mar 2026 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxstMwxX"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E72F2619
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758237; cv=pass; b=IM4MkfaWtaW7eDnnFEqQZvtcfUGkF07xNgLXg/93vR1T6bRuLCjqmhxxpRwqWMYD9hoSEEM5UT7n5bwld9YQAJhy6na+vWwsk+ctvzB20Fiu1A7By0YwVzq5Yy17t9PQlr6ZMA/JDWHF7/13poyc4Aa73SHMPxkan8zzPzHYHQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758237; c=relaxed/simple;
	bh=i4ud4eo2mI8fh0Sf1ZMn1viQtlTCtTS/9w8ujrJ1frk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pj8J5k+ZPcfxaCsxzvYCAgk1hky0y4sPZ4ZVek2XlD52zZRN3p/+8OehWvsO0A6hEfOR5dwKEx+bAW+Cww+yARZZbfSXRSAUVfJLWMAOSrtxDx6Vm9Xet7ipnAzi+llWjQLrQpF6FF0YN3Wr9lOP4Eth9nYkVQRWmTZFPq9Hb2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxstMwxX; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b8095668ebso536646eec.2
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 16:50:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772758234; cv=none;
        d=google.com; s=arc-20240605;
        b=b50txJqcb2d2Y9FebJcedan2K9+1G4uM9zbXpozfliHvDLWEhLMF+F4mYGxdT68OHx
         F5jjxu4v1yVRZNS+hcdE0dt5Hx5pdyuPSR4myhNYF8rTvhtke1JwA0w0TGFnFJWxAE0E
         pdGuFCt72xx5ftlcUIgmT3g3j7yLUWHJfws1a/5cmmf0bZeoHaUhd/HYpqcurgVC/OF2
         zvatncAmoaZJA+yebmcRHJ4ZNM1bsCo2DOj5wcJ9neYd5svCfR2DXKYavlBxMSoAt7ep
         6dOO3Bv6d3QHRe0pwKgUzEWvc3234X3B0XOHfcUQGRzfQFuUqAY24EkMCOuCTSRCQE30
         dDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+LSQkZP5fZkmW45ZQZQTw81WM4wYf3rA3zjGRvFQcWc=;
        fh=7/167AWKQHqKvL3QA0+nzM0A9sl1B5OmI7yRiF2JckI=;
        b=DHFcHF6djj9hCeCBs3la7csSWoYeEjYFPP+peFUSxFU9770WYUbZMTKkDaB3XxShnF
         ez/F4BAEC66uj1x7Un4u7o32iVGCLK9wxXcxykufuI1YNddQH073sb1lmQ3JkbViVGqq
         jbRFZcxkOanN4aLLpswmuwAE5Y3rhN5kJ09NUVNIC8e3jydtSr8wY/5hwywXiDdeOTd6
         VlChy8ruSQYB0Utw5NYGDuy6h7tajJagP1s0gpx4COYE38shoKgniKs5aATWA1fncaSc
         UZP1dYngcMNGHB6DC/rhCAjICzpf1u+nquNsS0zEx6DKcoC5yWscKFcwZPQUXPM4B5Aq
         nSnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772758234; x=1773363034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+LSQkZP5fZkmW45ZQZQTw81WM4wYf3rA3zjGRvFQcWc=;
        b=lxstMwxXcf3uzKgjXRJ8NcZMmyZQYFA5aR02wDwUMOP5HXEekBZJLKuAOl9LD5fKF9
         RoA/DvIlB8JEaYQPpAfxQD39s9vbraWjbXMcNVlPF2IsOJolvrRiOVQWPVoMrBg12UAG
         4HOtypQvkrpTK2SqMCz8qqcK+NGl7qKMtqIFE6nsibbPmCUefH3fd5pzHI6muh1umBP3
         QQo60kAOt0vWupP0JwvRJmfc1qPfQkqyum0aT985P07NAos2ntLb0GO3HUoPkmBIjppW
         LRk5TW80kUn8jGrJPHp26VMwDvwrKhkE1BRArJh7tb86ciQK2xGx/PD5NVkb+hwhc0DN
         PN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772758234; x=1773363034;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LSQkZP5fZkmW45ZQZQTw81WM4wYf3rA3zjGRvFQcWc=;
        b=qou8vJDPnM70+ziQsq+02md1rDevyp4gsc35UbU9e+OdbAGbftyZJDFbCViFLYUa4F
         O4DVM1lKNCfXgC0DSA13NWxg2byrfS6prBju51k28jr3YGOa1rcTMOlgY4uWYUJdLROs
         lEk9T1yqWWTsS3WAoXyN2YK5xnpAyGOjuF2de08bgwAI+dtUc2iPEHoEt3YfVMFB7ZhT
         vvjBsxPxDl9xcgjrpbvKzXYSSO+471pVdW7TU6yQb0/l6nm9mSAlnmh7BrLAdSbm2GE8
         ZH6WFW+M9ocvHSQ3kmn+lPWdPO8ZvHw2Uey0zqnGMJ88x+VajnRMdK4KSHwNJrqGOYUh
         i0tA==
X-Forwarded-Encrypted: i=1; AJvYcCW4WGqvpGnf6BDC7ALJ6XJunas/2j7Yvmbtx1jH9wXmfDDVtfaQtL3dGcG3w4NXM861myWsVhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4evGt8js/5WGmkwhwI1zRngWOlJVew0VCF1K4Z5r+yCPWv7Ir
	A1qZBl6YlQ2Yya45gQ7Sa6UwbR7xIpqukW5uXOEtnJGycwfhzxuQPugg/HeVyE1wvL8ms4u8mSA
	W4D1qPpKRH4SUulUIKb43kJhEPotqtWU=
X-Gm-Gg: ATEYQzyANhpNUtJ3HvNZSOntdB3UfreeOfQoGmAajrVDE+ZPVCU/Y4ESDTtALMBnMih
	XHKmnJ+lnCaEjESXWJvzM123H6Fj933i0BEgQ8NnFqP2tw+UZOniiY7M7RAdvl43mr4ZoKRfiDV
	kUveU6/H8SjmuAMIu1ZKrR6xhc+EK1Hb3Gm82LhenWyJ9GalxkZE+gYIh7E1mMXvL7BoECFxKXI
	qFUgcgHX6Za0fc8UGPKXjHFhmwq5k5ibl9+O8twvhuPKF567+7Z7TE6uDNtJ2KorACxrBDnlVLm
	+ncKnvXfS8FH75MfupRU39+TPjfDHchlDyFPE1LS4pfVCjSCdM5jZ/svcBlV1CgQk4XB8g6bnZZ
	z15sLImGlczRU7UZ+o9I6YCxs
X-Received: by 2002:a05:7300:af06:b0:2b7:e929:856b with SMTP id
 5a478bee46e88-2be4e0f0d27mr68321eec.5.1772758234355; Thu, 05 Mar 2026
 16:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Mar 2026 01:50:22 +0100
X-Gm-Features: AaiRm51fJj-lB_Vdi9mAOrCvECoNeW6xZZuubYbCPEUWNrISXt6kj-i7O8plQIM
Message-ID: <CANiq72=hgBskGz2LV+gN_g6motfXMHjYe5e_ZaaxzZx+TA06LA@mail.gmail.com>
Subject: Consider backporting 7dd34dfc8dfa
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CA0E6219FF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223289-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Greg, Sasha,

Please consider backporting:

  7dd34dfc8dfa ("rust: kunit: fix warning when !CONFIG_PRINTK")

when it hits mainline (the commit had a Fixes: tag, but not a Cc: stable@ one).

Sending this now before it is forgotten to avoid rebasing the KUnit
tree (we hope it is not too early!).

Thanks!

Cheers,
Miguel

