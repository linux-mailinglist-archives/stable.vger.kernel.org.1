Return-Path: <stable+bounces-272861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HWo3MG55T2rjhgIAu9opvQ
	(envelope-from <stable+bounces-272861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 12:35:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FFC72FAE1
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 12:35:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=a1tQ9V74;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272861-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272861-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24038305D13D
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 10:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86740BCDD;
	Thu,  9 Jul 2026 10:13:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA053C0624
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 10:13:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592021; cv=none; b=koGdRGnFW10Z9N3FEKG6tbkucvXnvsaED+pGYVxa3ZleTQ1T2NOG9WTaovZqjrZVwehWfE/pKBjfJS2LWPgVv4DHIkWxijATFzJBaZFTtQtqbeMgLKxXov1CpzvIsiNxP7TQy97bjl+fb/hM4Zg3we29tiiTp46tDjLj6e9ZnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592021; c=relaxed/simple;
	bh=xQmBxphDa1xFrmI6W+JXkKRcOnX9uJkuJ+MRhIqYj0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUzwwkhm78xmq+l6/sdIg9JVYWrgOdjaohRdXZU+bfuZPOsQsa4cK0AuXY+GY4tW9AxABAA31YNoN9aNEqbXWxltgCpdnUh7HmBdED0qr8f0QKnC2rQGPcI128698hPanKoSXIyESCQ1yxecFZ08Q6KaN5h+c26rOHJYtN6Ltt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1tQ9V74; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3811e59df58so1103809a91.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 03:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783592019; x=1784196819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xQmBxphDa1xFrmI6W+JXkKRcOnX9uJkuJ+MRhIqYj0o=;
        b=a1tQ9V74DAsM5NBDHGa2IFBd6HkM2fDLdkXmM1gSeVz7Pd3B7GPOvmIuPzneR4R70I
         1vkjaGVHGrUpho4k840zDoL5UKT1F6CQn3ztONvHaKoBGmqoq8zV0RFLoLJgdhj74sBH
         iLF2PfOdMKEoKrfOigOWORRhaZqxORbcO/AwaQwBEU+ZTtMo8wl9Im6pt86qBkFfnnvG
         jnQkYwqEozQ8D8iZ7Fc7AQVhD4PO/G7sIAEyj7MU9+hVkal1AJQ1zBIy3bpcaz3QbFx3
         woJ2D5ndDgOwcIDnrlHYUeQIMCr/96eXoFbnqYkCR62Tkw8FT8GMmJr2Lbq+DG9LuIO8
         V52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783592019; x=1784196819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQmBxphDa1xFrmI6W+JXkKRcOnX9uJkuJ+MRhIqYj0o=;
        b=r9qUNlQEgafpgEz8Q/62t8L9k9Hi1ElChHCmGnTbj4OFMvyeVTl2Y0iyOfS2u45Zqf
         vepD6MqZ42VsPcTbIdgtK64PwcscDk/KQxoYM/xxEPQify8x4Uw/GXslhvR9Zi0M0saR
         oTsZVhBr2ZhwUn7pVsCo1t4NqFjdzZzQUlBimPWnEQi8j5NNmMT18aEIl/4oWSl4QLzZ
         hR4bKFM2CM3Usdl4/5qVZAmfmEK+Wl5V2KDkuqboKz3+lqx+O6UfMk17IrBSkKkumOL5
         OCrv2T0QnY3Zx5uMfFQ+D2oP8Bwgyj2ia4YOZ/0A4NdfeDFWL0NXZRFzfsAC9GbLj2bo
         2psw==
X-Gm-Message-State: AOJu0YynWD4dUZ5BQX5MGnrzCixIHuvk/poXK7YBarw0rF53tQeOV+5Y
	OF7y2ktEzehd9CC5otlNyTTo8Zu7Hq/Gv0ZPCQOxrFHYO+i0vKo3Qnrb1P3vbID0PN0=
X-Gm-Gg: AfdE7cmXNaWMEpRdsirwkF8K4GN7PikW4CQM9xpuMrruBpVnB5lSOXVbosasu/7RJvm
	/3bUQFLezY7k7bRn6i+XdO1XlbZQOkQJTnRks6v2xpnIiADk450fFRSyQEIUetuIpy38Kydpg+1
	NwDJ9QxCfw3A8AW3zf7eU/i+kUy4Bxn81u1IkVT5+v8Zf8RvVj9kY75LxCXb5QWzHnbRUntuZcq
	raG4P0q7xKaMALvOMcluC+5Cu7wpe1m6WEmiTRzQkbV9Ny5YTAJKMkGjWlzLja7uRP8qvoNI2gd
	Tg1bsgTraRqcVLiBbb73eWrQz1JIADbYD+97e0zfpp2wjBFW+AWn6SywTL1LcbEHfAEImB8GBII
	yumjDNpVkfMA2wJIft5ZJkhBDh17rdS4W1AN4ycJ5Et+1zUKstTUyel6iJ5U4mPhlgp6CiiHMaY
	cbtSnu135Ur6iieVwcmb7avrw/LR1izYoKcRWW9Q==
X-Received: by 2002:a17:90b:3849:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-389402490c1mr6834337a91.10.1783592018896;
        Thu, 09 Jul 2026 03:13:38 -0700 (PDT)
Received: from DESKTOP-82PPU4A.www.groyaloy.local ([202.8.116.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm32071423eec.31.2026.07.09.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:13:38 -0700 (PDT)
From: Ujjal Roy <royujjal@gmail.com>
To: Linux Stable <stable@vger.kernel.org>,
	Greg KH <greg@kroah.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Please backport bridge multicast exponential field encoding fix series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
Date: Thu,  9 Jul 2026 10:13:27 +0000
Message-ID: <20260709101327.9508-1-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272861-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:greg@kroah.com,m:gregkh@linuxfoundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:shuah@kernel.org,m:aroulin@nvidia.com,m:yongwang@nvidia.com,m:petrm@nvidia.com,m:ujjal@alumnux.com,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[royujjal@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9FFC72FAE1

Hi Greg,

Please consider backporting the following bridge multicast fix series to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.

726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation")
12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
e51560f4220a ("ipv6: mld: encode multicast exponential fields")
529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encoding tests")

This series was merged via: db314398f618 ("net: bridge: mcast: support
exponential field encoding")

I checked that the above upstream commits cherry-picked cleanly onto the following stable branches:

linux-7.0.y
linux-6.18.y
linux-6.12.y
linux-6.6.y
linux-6.1.y

Thanks,
Ujjal

