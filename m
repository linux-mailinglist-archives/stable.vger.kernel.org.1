Return-Path: <stable+bounces-272071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id arAtObNnSmoiCgEAu9opvQ
	(envelope-from <stable+bounces-272071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:18:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D18F70A46F
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:18:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=callumwong.com header.s=tm32yydslvviquw2x2q4ycbntmmm3paz header.b=g4dR6evD;
	dkim=pass header.d=amazonses.com header.s=ulrbq2zjesb42hdt6rpnifgor3epinsy header.b="Mn/g5K/i";
	dmarc=pass (policy=none) header.from=callumwong.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272071-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272071-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0821300F9DC
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 14:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F2B3815F1;
	Sun,  5 Jul 2026 14:17:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from b232-12.smtp-out.ap-southeast-2.amazonses.com (b232-12.smtp-out.ap-southeast-2.amazonses.com [69.169.232.12])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A816C37FF41
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:17:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783261025; cv=none; b=k8I9iS80hegICc41eb1HK8ND19jZmA4+NWVg1xdrI53VeHDbZXxl4UBES22pdcDCXTUm2X6AtqQpLW7iBEAiDd5LJCWuHJlmINXCw8IjvOYVuIbEU+fdrs+3ulKrr6AdkDiYsTvPcl9jkymidQi57L7GrhK9cUDwWYv7gy8LGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783261025; c=relaxed/simple;
	bh=/WqMBAa7Ytdpy/iYnElYCAeZTp9y9w7UfskxqkelEgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua8uGCMbBmpHIxNZUJ5sYPINcDXygdByNytRD6OuM6RgiwWuJQCYEq81aJfvFowYh4cHEjo2np14AbKr1nMhOfI6FE7gqSDtrOcSZf8OoNDoH2iwlZOfY9n0coqPTEP0TQN5D99GbMqDnwPSPrSGFvwiZeBlu6UXXu0CRtnRszE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=callumwong.com; spf=pass smtp.mailfrom=bounce.callumwong.com; dkim=pass (2048-bit key) header.d=callumwong.com header.i=@callumwong.com header.b=g4dR6evD; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Mn/g5K/i; arc=none smtp.client-ip=69.169.232.12
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=tm32yydslvviquw2x2q4ycbntmmm3paz; d=callumwong.com; t=1783261021;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/WqMBAa7Ytdpy/iYnElYCAeZTp9y9w7UfskxqkelEgE=;
	b=g4dR6evDhsAnQApF9dSYnizd/ybLLgZX7DLMA3IUSb+LLNcVlq9Q2nBqULOMljgp
	0GUjQ3zYgv4NNyvmspt53zzqelpuaWloLDgeq+HbLxXosUApGfiaYb8I6kSzz/1KrXt
	ejHCfPDS+WLuAgN/JtYGd+kudgW0ErwI+E5XhHz9Qo8O6gbtfXgrY8YnNhdj1qKGvKL
	5XQqgL4iy+bxHrGTQipWqM9ySsqLr0w/RxZ4imtllLZAxoaDLX2MYNyy4Y15H5E8dCP
	QoCkt5dfMdZdt2YPPHjv8dpzWVKFFVKpT3CP24cpxAJAev1ZTYE3w+NcgzGeKG6eRDw
	fj4CrPUquw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ulrbq2zjesb42hdt6rpnifgor3epinsy; d=amazonses.com; t=1783261021;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=/WqMBAa7Ytdpy/iYnElYCAeZTp9y9w7UfskxqkelEgE=;
	b=Mn/g5K/i5WCT1qjDNuPr2EtRmbaCaW/GKSz2ToI52AdDccWUNMaC/jw8blrt3ATI
	zjFgyKrBwyANcz9p2v/Uk67/c6OhlKD8MGlvjrjZaV7H0OZXZUPamKPd175x4pOY/nx
	Prq0msvzKBgxebq61qs9asKCkEi/PsHmnELb3KIU=
From: Callum Wong <mail@callumwong.com>
To: mail@callumwong.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] ALSA: hda: cs35l41: Support HP OmniBook 7 Laptop 14-fr0xxx
Date: Sun, 5 Jul 2026 14:17:00 +0000
Message-ID: <0108019f32a3c2c3-6c45997f-be66-4ea6-86a3-e6d8bc5493c0-000000@ap-southeast-2.amazonses.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705141657.180320-1-mail@callumwong.com>
References: <20260705141657.180320-1-mail@callumwong.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.ap-southeast-2.Bo07if0thBjjxfhnG0PllidpkDb4AFgWjQ4XZlpgJDk=:AmazonSES
X-SES-Outgoing: 2026.07.05-69.169.232.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[callumwong.com,none];
	R_DKIM_ALLOW(-0.20)[callumwong.com:s=tm32yydslvviquw2x2q4ycbntmmm3paz,amazonses.com:s=ulrbq2zjesb42hdt6rpnifgor3epinsy];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272071-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mail@callumwong.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mail@callumwong.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[callumwong.com:+,amazonses.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@callumwong.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[callumwong.com:from_mime,callumwong.com:email,callumwong.com:dkim,vger.kernel.org:from_smtp,amazonses.com:dkim,ap-southeast-2.amazonses.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D18F70A46F

The HP OmniBook 7 Laptop 14-fr0xxx (SSID 103C8E3B) has two CS35L41
amplifiers connected over I2C. The firmware provides a _DSD, but as with
the other HP laptops already handled by this driver the properties are
not exposed to the generic ACPI path, so the amplifiers fail to probe
with "Platform not supported" and the speakers only play at a much lower
volume. Provide the configuration through cs35l41_hda_property.c
instead, so the amplifiers probe and drive the speakers at full volume.

The values are taken from the machine's _DSD. There are two amplifiers
using internal boost (1000 nH, 4500 mA, 24 uF) with the speakers wired
right/left, the reset line at _CRS GPIO index 0 and the speaker-id line
at index 1.

Fixes: 7150d57c370f ("ALSA: hda/realtek: Add support for HP Agusta using CS35L41 HDA")
Cc: stable@vger.kernel.org
Signed-off-by: Callum Wong <mail@callumwong.com>
---
 sound/hda/codecs/side-codecs/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
index 416d7bf3e289..1d2a83b47cde 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
@@ -85,6 +85,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "103C8C51", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
 	{ "103C8CDD", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
 	{ "103C8CDE", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 3900, 24 },
+	{ "103C8E3B", 2, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "104312AF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431433", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431463", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
@@ -511,6 +512,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "103C8C6A", hp_i2c_int_2amp_dual_spkid },
 	{ "CSC3551", "103C8CDD", generic_dsd_config },
 	{ "CSC3551", "103C8CDE", generic_dsd_config },
+	{ "CSC3551", "103C8E3B", generic_dsd_config },
 	{ "CSC3551", "104312AF", generic_dsd_config },
 	{ "CSC3551", "10431433", generic_dsd_config },
 	{ "CSC3551", "10431463", generic_dsd_config },
-- 
2.54.0


