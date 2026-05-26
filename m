Return-Path: <stable+bounces-254419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJi5IKLnFWrdeAcAu9opvQ
	(envelope-from <stable+bounces-254419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:34:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C48F5DB62F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B040330309AE
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6650421A0F;
	Tue, 26 May 2026 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="gxqpoBC/"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95430AAA6;
	Tue, 26 May 2026 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820442; cv=pass; b=ExaSuug9bRRKPHy7r7+C7mU4Gg+2M9Puv2LSn+GSEdBfa1XKh7unvKtbhG9uPgaf7al5AlLBiTH11NI+m4WthHZxZf0JVe8Da1uN+hh2ta0jk1iQgExJbPDkkSHlw08CSsVB99hEdz/gamW2Mz59Xf/YDcDxTNP4c9zDYSxFnh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820442; c=relaxed/simple;
	bh=BpqlJLDSI4PvBbxwYLvjZiqgdzBk9N1STMU3LlOUU/w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X5wabcQ2sXQaCQ4rmyosPjo7vDDWxlHH0wfTGdGMiKngYV7Fdn1G/NHSxzSPBzV/7594H1arzN6wAQh7rRdTwfw+HOYyw8Tf8eyhpvdYloWwAtlSU/fuTylm5ZpkGCLtn/OEReuiClI7mFHiyUd78AzSaWvNXBZy4AYb+gWMvFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=gxqpoBC/; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1779820431; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VCTBVBXC8CZCYh5DQceH1ag5CjpKeWddtEfnus5yror7kuzoIZ+waJYzgMl05DkkfmnY2MsJKrEH8cVgMzeSLeFgxA9uD/lS9E0ySM5XigN88kAc0Mbur3VQElg5z4rK5zQ7BRuApVeOJpjJaNsH0SOqHyUR2P6SwkM+jMrHcUQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779820431; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FN71WW8i75MCQ3YGdXkp6wRJ0dlwg7XQXcEE0r/D4VA=; 
	b=UzQ3Xdp6pDfHvG/pDwZpAf0NoxWWl460G14nSoembn27y/fkpFPDwjSPqgiUzLj9ySzDtZtwaq0wxD3o432Cw0LamBPorTJrte2xz1QWja85r4Pc6BRN5VhqHavleGGZ7TYne/+sTkYVRloKnDnB5UuOGKRSvJ+Cm2qOxINTEKs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779820431;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=FN71WW8i75MCQ3YGdXkp6wRJ0dlwg7XQXcEE0r/D4VA=;
	b=gxqpoBC/Oru6PKBHABNJgcCBjWOJTsQLbTAYZXcBPdgPYSLDndzhsPPoOofdHiQv
	7CjZ7pLjwBmY+sZt4D6SzT6F9a/ai9+sWeZtj1GKDmuGwHPTL/PSD7DhvxnP1bS7vkX
	UtHCHeQtNcoeImrzKf0uLm03ChUmDC197KabvjtZeMChgZfjpvxwzNiVn3kAYFzbRZ4
	9OozJkRz0BXiehnKNeO55r8GDVFDvVfdss2mcGkaD92QS4HBhsuplnoGy12Usqvoqxn
	zARaWJZ46xraZc+4NhdWIEj8ZVfxIOFOnNE8WQeMMTJb6LD7MyrSngftAM2EVlnIqCH
	pZ85uoIDMw==
Received: by mx.zohomail.com with SMTPS id 177982042902850.25350291014263;
	Tue, 26 May 2026 11:33:49 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH 0/2] ACPI: battery: Do not generate too much pressure on
 ACPI methods
Date: Wed, 27 May 2026 02:31:30 +0800
Message-Id: <20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAALnFWoC/yXMQQ6CMBBA0auQWTtJW0HUqxAX0zLVcVFIOxoN4
 e5UXL7F/wsUzsIFrs0Cmd9SZEoV9tBAeFC6M8pYDc64k+mcQd8ihVnQkyrnL6ZJJUogrSFezNi
 fLR2jsz3UxZw5ymffD7e/y8s/OejvCeu6AaC8hnKAAAAA
X-Change-ID: 20260520-b4-acpi-battery-notification-90d781a3f217
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, stable@vger.kernel.org, 
 Rick <rickk1166@gmail.com>, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-d5d98
X-ZohoMailClient: External
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[rong.moe,none];
	R_DKIM_ALLOW(-0.20)[rong.moe:s=zmail2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,waelti.dev,gmail.com,rong.moe];
	TAGGED_FROM(0.00)[bounces-254419-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rong.moe:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@rong.moe,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,waelti.dev:email]
X-Rspamd-Queue-Id: 7C48F5DB62F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The acpi_battery_get_property() and acpi_battery_notify() callbacks
sometimes generate too much pressure on corresponding ACPI methods. On
some devices with fragile ACPI implementation, these methods share the
same mutex protecting EC accesses (hence slow to execute) with a lot of
other EC-related methods. Such pressure on them eventually leads to a
catastrophic situation that a bunch of ACPI method calls fail to acquire
the same mutex due to timeout. The firmware of these devices doesn't
handle mutex acquisition failure gracefully and return garbage data,
causing even more chaos.

For acpi_battery_get_property(), it generates too much pressure on the
_BST method because of the lack of synchronization. In detail, it
sometimes nullifies the cache mechanism of acpi_battery_get_state() when
multiple processes read power supply properties simultaneously, which
usually happens after a uevent. Normally, emitting a uevent implies that
the cache must have been refreshed due to power_supply_uevent() reading
all properties, so the mentioned processes should have seen cache hits.
Unfortunately, these fragile devices' power_supply_ext properties are
somehow slow to read after battery events, resulting in cache expiration
before power_supply_uevent() finishes. Hence, once the uevent reaches
userspace, the _BST method will be executed multiple times within a
short period due to userspace processes reading all properties again.

For acpi_battery_notify(), a very common pattern in EC queries that
emits two consecutive battery notifications with event IDs 0x80 and 0x81
updates battery state and calls power_supply_changed() twice within a
short period, generating significant pressure on _STA, _BST and
_BIX/_BIF methods. Not only that, power_supply_ext properties may also
rely on some other ACPI methods, so both uevent assembling and userspace
processes call them. It becomes a nightmare when all these methods share
the same ACPI mutex and hence vulnerable to lock starvation. Even worse,
after the first uevent reaches userspace, some userspace processes start
to read all battery properties in order to refresh their internal
states, which competes with the second notification's handling and
uevent assembling, exacerbating the lock starvation.

Fix acpi_battery_get_property() by protecting it with update_lock to
synchronize it. This also prevents potential race conditions, e.g., when
multiple tasks read power supply properties simultaneously, or when
other synchronized methods are called during its execution.

Improve acpi_battery_notify() by merging consecutive battery
notifications within 10ms using a delayed work, so that they only
refresh and/or update battery state once. ACPI netlink event and
notifier call chain are still triggered multiple times in order not to
break other components. Finally, call power_supply_changed() once and
lead to a single uevent instead of a bunch, preventing userspace
programs from causing too much pressure on power supply properties and
the underlying ACPI methods.

With the series, the lock starvation issue on mentioned devices is
greatly improved according to the feedback from one of the device
owners.

Tested-by: Jeffrey Wälti <jeffrey@waelti.dev>
Cc: stable@vger.kernel.org
Reported-by: Rick <rickk1166@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221065

Signed-off-by: Rong Zhang <i@rong.moe>
---
Rong Zhang (2):
      ACPI: battery: Synchronize get_property() callback
      ACPI: battery: Merge consecutive battery notifications

 drivers/acpi/battery.c | 113 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 87 insertions(+), 26 deletions(-)
---
base-commit: d60ec36cab338dfe2ae40d73e9c8d6c4af70d2b8
change-id: 20260520-b4-acpi-battery-notification-90d781a3f217

Thanks,
Rong


