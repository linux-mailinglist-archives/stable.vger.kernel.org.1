Return-Path: <stable+bounces-274620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gZzeM4LQVmr8BQEAu9opvQ
	(envelope-from <stable+bounces-274620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:12:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B6E7599BD
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:12:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FWnx+NYf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274620-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274620-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF00F301DD0F
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F063E2AF1D;
	Wed, 15 Jul 2026 00:12:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C674242BC48;
	Wed, 15 Jul 2026 00:12:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074367; cv=none; b=BtJGg/T1488Xago3ERpHdZMOnjOIZ8PbC3TgNT500pHEXlV4CpzjoEedZR3q6hBH6a7FxkQgkICg7mMa6AIa04tykc54PLYJs9PRjFRd/9ZzX7EkF+8FHKzxq5X3D9lFZn7JcIQpqduZCmhd72UXtc5F7lHq8BWU3/heV2Hbdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074367; c=relaxed/simple;
	bh=CWM9F1iysRhwkY8shCmhGLfQhqdIpHfof0/a13aSaZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5mvq3Deshp43YHytYjR9KwWWSulMuQ1phv5W+F6PRxICsNnXJbgN1XCaJLxqldk/jQD4XpScxXk+CXD5I/+dHLX40QyZPWrSZEI0F5mEo7j6l7KbLtfSD538iK6HPgyqhJalBAgagjrLerT/Lt6nWkUDJG8pggo80o14AKynpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWnx+NYf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E4C1F000E9;
	Wed, 15 Jul 2026 00:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074366;
	bh=ozXR1slcn31dh4aPRCoJtnpI58JF0zu6o/7FlOEgDic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FWnx+NYfb5FwvhodlMCqyYy9nh3ePVb+3EJrWivJxXTvWSGs82XAB8VIaNaCfAPy5
	 Q3FbGZplUvSxCvjPSZ40TLOAypiEZz5xFWI+WM6pCfzbJW1LhKI0A/KR+Dq/KhaWGJ
	 UIYEWddX9euan+TWsq3cmbfVlR8oHSU5WMHgea3BtfH03wg865U2kX+cMugDjJE8dA
	 4LKczmP/eTHCNC/VDIiU6AmvcTsS/ViXEgkzzE0ibsfX4uVzg05YnwTmKphqJo7i1e
	 R7yBSHNUnUsL+QRgQAC404+8LwGj69OaCPOqrMejp4sh+ZDO78lAppi/M+kafGSqD6
	 O21DeDJrhipZg==
From: Sasha Levin <sashal@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hughd@google.com" <hughd@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"kasong@tencent.com" <kasong@tencent.com>,
	"baohua@kernel.org" <baohua@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?UTF-8?q?=E7=94=B0=E5=AD=9D=E6=96=8C?= <tianxiaobin@xiaomi.com>,
	=?UTF-8?q?=E4=BF=9E=E4=B8=9C=E6=96=8C?= <yudongbin@xiaomi.com>,
	=?UTF-8?q?=E6=9D=8E=E9=B9=8F=E7=A8=8B?= <xiaoyaoli@xiaomi.com>,
	=?UTF-8?q?=E9=A9=AC=E8=B6=85?= <machao26@xiaomi.com>
Subject: =?UTF-8?q?Re=3A=20=E5=9B=9E=E5=A4=8D=3A=20=E5=9B=9E=E5=A4=8D=3A=20=5BExternal=20Mail=5D=5BPATCH=206=2E18=2Ey=20v2=5D=20mm=3A=20shmem=3A=20fix=20potential=20livelock=20issue=20for=20shmem=20direct=20swapin?=
Date: Tue, 14 Jul 2026 20:12:30 -0400
Message-ID: <20260714200600.stable0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <777ee2cd231642c682560b41b29798fb@xiaomi.com>
References: <777ee2cd231642c682560b41b29798fb@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:baolin.wang@linux.alibaba.com,m:akpm@linux-foundation.org,m:hughd@google.com,m:stable@vger.kernel.org,m:sashal@kernel.org,m:kasong@tencent.com,m:baohua@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:tianxiaobin@xiaomi.com,m:yudongbin@xiaomi.com,m:xiaoyaoli@xiaomi.com,m:machao26@xiaomi.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-274620-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,xiaomi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61B6E7599BD

> We have conducted stress tests on over 10 pcs for 40 hours each, and no
> relevant issues have been reproduced.
> Tested-by: Ma Chao <machao26@xiaomi.com>

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

