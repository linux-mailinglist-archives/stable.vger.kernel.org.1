Return-Path: <stable+bounces-225298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM3XJtAEtGnjfQAAu9opvQ
	(envelope-from <stable+bounces-225298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:36:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CD72831C7
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18F4330850FA
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64DF3932F3;
	Fri, 13 Mar 2026 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUEpe/fd"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4A3932FD
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405281; cv=pass; b=jR1GNnjyqUR2eYYRE5fO+2P2xKwZfxFFcDSH8iPFlUYXkuYJVn7nPxf/yIWcn5c0PnvOG/sNHwhJ2V6UKi4e2zGi/XIZW0gVHS85TxvB4Lac4LriWQIwqrg1pUUaWJotHxVxzFL5Gn5i9rFhxXsEPciicJ8YSjt1q9aqw4WUWhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405281; c=relaxed/simple;
	bh=6WxhVFeYC4TLL4/+j8aaUc8CJZxbG54Lm7ZsOLppBs4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CbjpgVJd16xq54sY2QbMhV7XgbtY/s3ZzYWsUDHgakZy6kmFEKkhi+hEmcrxphulZV7Z/YTTBtlypQ3aavmdtZ9tRe6i3Db29arB9fAoiiL0E02b4stXOcq+qYeOd+6aeMGoFGOYi8LsGJw2J94TtAoMMaBzaIk8mGL9ebsxyUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUEpe/fd; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7986e0553bdso19096497b3.2
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 05:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773405279; cv=none;
        d=google.com; s=arc-20240605;
        b=TMqpOhFYk3TeYOXxyBFhjxUvMk/UsEEWnGTSlfx5IxXDX5foZnZyJmhOYgy4pdR3cy
         kk4ZVOkQhsjNkZL+bdTtSTP9db5OoPR1mq8q2IBl+Fvp/5UMZ5q7tT5i9Wh3pRuHIOfy
         xc6Z+ULotVaf6C5kSw3if/Tv1uoei8B/m+EPQg3idOTdbG8KSUMLh1HTYs5KpZFuciTz
         RSNEKFJzS6s1ceZokpn/u5Bq//to47vVbjB50MJvjoP6jtdv0HFOOLS+1kV7pYARKR/d
         3pTqk4N3PenleLxint8O9TpcVWaiTPODZFjE6mQtShreUYRM2AaVElxGZgwXQMQ4anRP
         maRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OByltBqZ4D1Dl23TWIoRa0kwReSX/0ZMHtZbYn9nx4k=;
        fh=o2JvoRqK5gX8RIPXcYrc8bqbjYJgCf7bWBt2F2OijlA=;
        b=YHZfMmg4TTbielmcdayENmY1BPHohPPY0ypGC3ueR0/IHwjjy91Nn4BaBkf0gyQEGr
         vQ289ru5H7pNVuNWQHUdUTG4LdHhKDpGVsb2bcWCxm4wTHuo2rzRzCW0fCPGjBHPfO6X
         JUHI0LJjiasKbq3KJROBDjmQ5zaI5vmLfOfHzMgl3YIBiPyn1/tH8NUl7q9pOm2dBXc1
         aIS3vfd4mIvoe/UGwoD5Zx8VhnF1xesEZZUFPA4gdPpOqyT9uR5WXkwAIqxxgm9kc0eb
         wWMInlQDgvWoyQAU+tj4XbnF+fgoBnPIQtJ+2QbHP6rvUTTJWaCiLfWFI1HQ7qUVECsq
         JS1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773405279; x=1774010079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OByltBqZ4D1Dl23TWIoRa0kwReSX/0ZMHtZbYn9nx4k=;
        b=qUEpe/fdk4tF1WRXmkcKfhhmHpXfC5tO5lw4JqYf44aDnDk444YacstOtTJiVCSmUq
         PxQ0RHyPfCesmB4nyvo56FEinYXiKX9AP2HK+LQtuk4aAEese5k1RsPrzk3GZiLDaADa
         dzPcHiQ/+8s8cFIcRFa/u9rBa1UELVQbHQMje2NWKr8ybMfsyUi2aM3Evmfzp3wX6N70
         7sFfzxG8InRgsUjxR/muC0J0PNSrRp7ClEE1Mf2EaESSP3ua+VoHyKZ7uRbOcTcvDwDK
         lYNEg4w0F9Eu5uDgwIluG4PrTB3+dTFGTUZA7J+/AU5Grx876ODQowAUHxThX5QmuI1h
         jDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773405279; x=1774010079;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OByltBqZ4D1Dl23TWIoRa0kwReSX/0ZMHtZbYn9nx4k=;
        b=P3UXvbJ+/YFXBegzPtD87QpqTi4F1lPOjtt87u83FHOLyBHbnFt8l+8MOmiQUao/+z
         hx0qhofYpkB77E+VK0AkWJPW+Mu6bswhNJXJZWpcSsgb1nxstxyU5JZVnvgbuw0ffJHj
         1WFrZ2OZq/tlXqFSsbMIrkQ2d60KnfqQ8fynqMAdppt1JUFD6wX0P1dnFHC5/bKfL1ht
         z5/DBLn4u9qaOKibQS1r2ENHjHYUANOfj2SAR/Q8BOM8InnBecVyCqmBiWFbe8K7JfWv
         /AhpsocMLBCGP5PCSfUxRT2KSzcB6bGzluCkBWYCxFoIxdk4E6kD9V63eYWsuKUOgWMg
         1MWA==
X-Gm-Message-State: AOJu0YzwM+iBLxPJNsOg9/EeTVGOwnMCb4oyymdNVDs5LIgQcKmRalgt
	ZJ8aJ+cDAL2HWHLfnC011yY1kWB8r43ohvva12REXuHdfqp+e5R8WuFKCsab5sXiAVWL9Mxnfbk
	YIlK70hwFybaPysG8kcd8n+qFWqwlEesTXDl3SpqfVZptkTN3EolFVu/1FZQ=
X-Gm-Gg: ATEYQzydt9u+7Y5lTpGnNGQI5HI5I5Vac8eqvRUlejhkTML9A9TP3TVShf32zk+ntEb
	/qtN1VawQMJbji/+7ePEjs4oTm904P45bB6nA82QflRKTpF/sTmmu6bsSQ1y723p2DRq36n3okc
	9ichWnuI8gnsbG8yNsQ1pJcoXWhnT1ci59LtAp0ALrxwOKU9hVHkmlvrZy/C5HhFVXh5kHf0SLb
	xovH8XUHvVSN/pcHAh3iCJYcULo9jChr/LftOICsWpHubUBCyAvIyMTuFHNCUm8mkuUMrArO31m
	eYyivpCe
X-Received: by 2002:a05:690c:dc4:b0:798:7309:a427 with SMTP id
 00721157ae682-79a1c18327cmr35539667b3.36.1773405278559; Fri, 13 Mar 2026
 05:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Mar 2026 13:34:27 +0100
X-Gm-Features: AaiRm50n_0iR2lmIPYhN6j8Q8cNGL7ixOUgBOgkanrDJePArqRQlGKY1FxBFf9c
Message-ID: <CANn89iJzYON_QPGsgXii6r5tONLU+PepfP-b6J4MGguB979BQA@mail.gmail.com>
Subject: Backport to 6.6 and 6.1
To: linux-stable <stable@vger.kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225298-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 25CD72831C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi team

Would you be kind enough to backport the following patch to 6.6 and 6.1 ?

For some reason we missed that the issue was serious, no Fixes: tag at
that time :/

It applies cleanly.

commit 795a7dfbc3d95e4c7c09569f319f026f8c7f5a9c
Author: Menglong Dong <menglong8.dong@gmail.com>
Date:   Fri Jan 26 12:05:19 2024 +0800

    net: tcp: accept old ack during closing

Thanks a lot !

Related : packetdrill test sent to net-next today:

https://lore.kernel.org/netdev/20260313115429.3365751-1-edumazet@google.com/T/#u

