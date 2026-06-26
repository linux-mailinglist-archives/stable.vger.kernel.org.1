Return-Path: <stable+bounces-269034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z5rhGrCkPmrtJQkAu9opvQ
	(envelope-from <stable+bounces-269034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:11:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6668A6CECAD
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:11:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Z2qgi+jN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269034-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-269034-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92AE93006933
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5333EB0E6;
	Fri, 26 Jun 2026 16:11:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3E39D6EC
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490268; cv=none; b=DIXBUpbuBYhzkNlrYnmLYz9fRNkfUPM+qTqD7blDLTPwxamGjFKPsO+ndXKct/Hbv1l9shDTswdyiXDkd17tHFzqeoIkOTuRtzxGfNJau4/dIH8ibGQiXPiSuWvwSKGfiZQvN9dweRJzhXnR/qphQVOOfRGaKvMndKhpYnq1Lhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490268; c=relaxed/simple;
	bh=wUn9ovWH5PZ8EsHUZn9anweNhD6mksGzB+76MCQKvsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QL/UHR61CBYXYtnFXMlovIprCujeEYum03mRKdWt/iFe6KS3b7vxs+y0t73SPeGi7h7kgkh6Zd5y3P1Ri4Yl7NXjaRq3EXsc/bDzuJ4zJ9B25SxXRyumhhd/hlVoNEltaMs4j7XoT8Zna/2VSBilwApDqmOiRC7G6RYz7i1HIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Z2qgi+jN; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id 55E4E20019;
	Fri, 26 Jun 2026 16:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OXekX/1f3xfGo+2n5i80Dki6SuLp7N2dQcHqJRK0W6c=;
	b=Z2qgi+jN1m8cpDKhTW6ujevn7nHZ+log486ERBfkL4nGc45tvpFYBF8+IwspHwW53vCBF2
	Mn/c7flLunRLUtkHtvDDVbY/8EOJoPqmJkpDX9ghw0D3CHp+mSXFvZAqyHOwdItBMbORsT
	95BvIW2JDcWbmWSfvEme8yXwEqZphJ8=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.15 00/25] batman-adv: 7.2 merge window fixes backports
Date: Fri, 26 Jun 2026 18:10:39 +0200
Message-ID: <20260626161105.124113-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
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
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269034-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sven@narfation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,narfation.org:dkim,narfation.org:mid,narfation.org:from_mime,vger.kernel.org:from_smtp,open-mesh.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6668A6CECAD

Hi Greg & Sasha,

there were quite some stable targetting fixes in the Linux 7.2 merge
window. Unfortunately, there will be quiet some conflicts for older
versions and some order dependencies (often to patches which have
conflicts with older kernels).

I would therefore just submit my backporting branch
https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/5.15 to directly
provide the backported version of each patch. If it is completely
incompatible with your workflow then please ignore it.

There is no urgency for these patches. I just want to reduce the number
of conflicts and patches which are accidentally missed.

Sorry for the noise. I hope to have less stable fixes future (at least
the ones which have extra dependencies).

These backports expect that the following patches from 5.15.211-rc1 are
present:

* batman-adv: tt: reject oversized local TVLV buffers
* batman-adv: tt: prevent TVLV entry number overflow

Regards,
  Sven

Sven Eckelmann (25):
  batman-adv: tp_meter: keep unacked list in ascending ordered
  batman-adv: tp_meter: initialize dup_acks explicitly
  batman-adv: tp_meter: initialize dec_cwnd explicitly
  batman-adv: tp_meter: avoid window underflow
  batman-adv: tp_meter: avoid divide-by-zero for dec_cwnd
  batman-adv: tp_meter: fix fast recovery precondition
  batman-adv: tp_meter: handle seqno wrap-around for fast recovery
    detection
  batman-adv: tp_meter: add only finished tp_vars to lists
  batman-adv: bla: annotate lasttime access with READ/WRITE_ONCE
  batman-adv: prevent ELP transmission interval underflow
  batman-adv: tp_meter: initialize last_recv_time during init
  batman-adv: ensure bcast is writable before modifying TTL
  batman-adv: fix (m|b)cast csum after decrementing TTL
  batman-adv: frag: ensure fragment is writable before modifying TTL
  batman-adv: frag: avoid underflow of TTL
  batman-adv: v: prevent OGM aggregation on disabled hardif
  batman-adv: tp_meter: restrict number of unacked list entries
  batman-adv: tp_meter: annotate last_recv_time access with
    READ/WRITE_ONCE
  batman-adv: tp_meter: prevent parallel modifications of last_recv
  batman-adv: tp_meter: handle overlapping packets
  batman-adv: tt: don't merge change entries with different VIDs
  batman-adv: tt: track roam count per VID
  batman-adv: dat: prevent false sharing between VLANs
  batman-adv: tvlv: enforce 2-byte alignment
  batman-adv: tvlv: avoid race of cifsnotfound handler state

 net/batman-adv/bat_iv_ogm.c            |  11 ++-
 net/batman-adv/bat_v.c                 |   1 +
 net/batman-adv/bat_v_ogm.c             |  23 ++++-
 net/batman-adv/bridge_loop_avoidance.c |  28 +++---
 net/batman-adv/distributed-arp-table.c |  12 ++-
 net/batman-adv/fragmentation.c         |  22 ++++-
 net/batman-adv/fragmentation.h         |   3 +-
 net/batman-adv/netlink.c               |   6 ++
 net/batman-adv/routing.c               |  64 +++++++++++++-
 net/batman-adv/tp_meter.c              | 115 ++++++++++++++++---------
 net/batman-adv/translation-table.c     |  12 ++-
 net/batman-adv/tvlv.c                  |  69 +++++++++++++--
 net/batman-adv/types.h                 |  21 +++--
 13 files changed, 308 insertions(+), 79 deletions(-)

-- 
2.47.3


