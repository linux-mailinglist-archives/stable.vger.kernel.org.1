Return-Path: <stable+bounces-244471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kcC3AR7e+2k2GAAAu9opvQ
	(envelope-from <stable+bounces-244471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 02:34:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CE64E1B4A
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 02:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 821BE30151DE
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 00:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6867B67E;
	Thu,  7 May 2026 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCQ7r7Ae"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7081340DFD3
	for <stable@vger.kernel.org>; Thu,  7 May 2026 00:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114074; cv=none; b=Gr7T6mBpUkJl5KJjgH+2mckcpc1ebz21QNuPZXiRMBmwGMW+c9zMHX7IzcF3h+bKZ0Bno2m9Q5z4k74YlvKGgLIFdtDhGayTHUgWgTYEIUIU7lu6YFJEA4p1NTQVY7pZ5AeXf9hgFBvxAEhVirgLGi5XbMuHuBPW6ydM/csiFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114074; c=relaxed/simple;
	bh=29aihUt4aWmSHOAGirxV/stIKdylAvxvcEZukkF7pvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=amtQ96phUh7+YOjBzHUFaX9hNyFPQvy4UgTLobaeuRFzSQufg9NSYypx/TYaOl43kvhsHowIaonT95stId97YKP6j7i0qrQFoqgjz/Qk40IGOaWe6gjQxowyJnlMMO/uwdS0c52YLCFNnBg1DhYYn5Mwfxclypmeea5To2AAfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCQ7r7Ae; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c70b5594f4so31991485a.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 17:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778114072; x=1778718872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29aihUt4aWmSHOAGirxV/stIKdylAvxvcEZukkF7pvI=;
        b=fCQ7r7AeP0fkgvCS7epOodBd7EwDgw4Hw1ZSh8+/AhJfE9HQwU/T9XaAwX9RZITAX4
         GOl7S8hfWy6aMuqK5bA0XSBQKoOUbyE8JrWB5xwpqcuBnWdaklMWmsD9M9r8QSmzrMIP
         2stSTVvwrXz+78LIVRkPBuXKwNTJ+1uQAXVV5QzY5LAH1OMqkLy0JafugXORN0A/GQl9
         zm9Joci9C45l4QU0g+ruEcc2grmfiXIclm3BP5t8et4a6AHbkz58kS4vFP3Aa6hAAYjK
         aSNawszTGN4wDsBrLxaqMH9PHxUz3BVZ14RHCHb+3UtWny7/tE7fPUPZtJVI/syBgdIG
         XbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778114072; x=1778718872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=29aihUt4aWmSHOAGirxV/stIKdylAvxvcEZukkF7pvI=;
        b=pAq3bGlkTz4qFw6krDFOsWYHjIXOQGZeAJOkUDftaPPQBRocwgvTnGtnp5RttBFAVz
         9tVDtWuXiVfQqlXwldg0H7usBzZfJIvdQA58ep3gqpCw0BgTkT/EWPgy75zNo9aGt3tT
         p83pbUpR4GsGt0VYQ4OQPqq3ylgMa7/SH4FygKqeXgytZ0US/1LbJYDDwVgP6Bi2mVyT
         BP5OWtwHKMmTNsVSjvR/KDkUNVBuZRjUgf9rdHfOXhPBTDBayp9xyh09tNUJIRpmg6nV
         KfRx6EUEyd3azE26D9wkFq3pzg8YcKPQc3rgzYwjdgBisErgkkQTK/TVylKLR3F8RWLg
         rKEg==
X-Forwarded-Encrypted: i=1; AFNElJ+HsQAP06g0/JJSfU51TmorJtCuGQ+r/iXyqkvMueWBNiH3UxqlYrVYcZccY4Sb5P+I6VI6n14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNSN0IRmgSTHb/6j1yhCNrgdmtdtQtWSO0BJFArOhKNGXWrfDG
	KrIQ3GtXXO7J2VVmg2ktqHqshTjkJmJYwkC4vWNk68QvJbI33kM6AXbo
X-Gm-Gg: AeBDiesQv9hInoteYnBfpIW9TsiVTHiVbzeFA0wOFwOVYr1VrsHQa6vYlZmHL1RU/gp
	7Bpd3MAQA4b7gCuyQRERtK3ac9AwsoKuTMTSuCoSSwP9nexHNpfXcQcSbzAIOsgRv+Q8EV/+0og
	SRXGBYL6HkrOgqaT06z03vi2r3QIcbjcGNgE1PH7V+lo9W2x65M8qYdeGjMZENXU/VNznPjNqUR
	0E8n9V1ki9oQr4kipsVqa4Q9j1Wru5B5hGHYeyn4iYx5Ctc0fZa46KUvPd43YG5PlSXPvTxKOez
	Ga27DopU5SYQniJ45F2NarqAAwYsPjq0HXzxyKa2K2QiFU+H2UurxcIpBy6hefWspQpjI+Zh5Aq
	bhdxJm3oi436VfJDHfJpsIZJP0NLk1ZvsDquq2VZvaGym4c+UWUz75F2m85dG2weqHYTak+YRg3
	NGX/2Q2I/3n+5OqzVbhDBOq9dyGDrwL9Ow7bPGO0ZJ+MO5X7BAedv85MOoTUfI/HpPXbry3qfC6
	c7J2VUJFBqzr91uZRGdtkaz9sRzRAyWMps4kZk=
X-Received: by 2002:a05:620a:1786:b0:8cd:e013:bca0 with SMTP id af79cd13be357-90652c63a13mr111148485a.33.1778114072382;
        Wed, 06 May 2026 17:34:32 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d450dcbsm193358086d6.45.2026.05.06.17.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 17:34:31 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	lyude@redhat.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: Re: [PATCH] drm/dp/mst: fix buffer overflows in sideband chunk accumulation
Date: Thu,  7 May 2026 00:34:23 +0000
Message-Id: <20260507003423.985823-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410041901.2438960-1-ashutoshdesai993@gmail.com>
References: <20260410041901.2438960-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 57CE64E1B4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244471-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lists.freedesktop.org,vger.kernel.org,redhat.com,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

Just a gentle ping on this patch from a few weeks ago - no rush at all.

https://lore.kernel.org/dri-devel/20260410041901.2438960-1-ashutoshdesai993@gmail.com/

Happy to revise anything if needed. Thanks!

Ashutosh

