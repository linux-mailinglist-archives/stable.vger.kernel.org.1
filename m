Return-Path: <stable+bounces-240885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIzAL2Jz62kLNAAAu9opvQ
	(envelope-from <stable+bounces-240885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:42:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 347EC45F736
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A37E302DF77
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172853D5241;
	Fri, 24 Apr 2026 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hAmZF7u8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9633537DF;
	Fri, 24 Apr 2026 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038091; cv=none; b=nJYuUQ/5AOLCXhJvC/VB9W8EQ/N+JBOito/ohTvBXIcmx+ooB7jRCLCqbB12BXgVEMEOKmOD0CYsstupmqH+/gEytVaVLaNRKRQTCXVCsEmIgbc/VGJx2+9oVmCVOrqdAskJNDyqmjhy5bRGdyH/bUwMO7IDbbvlAYcl4ypcUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038091; c=relaxed/simple;
	bh=GxzZn9hvUqhlQyf3eh9/FJQ6uZSy79UPMZWoDcQjcv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctm7RFjMGytaCoD2STVM8Dgsa4hGS6vii9yPdUK3XMFwq6l5gU+6eavtUm4xmO2mwVXGcQZNXftSp2i5bh7FZ7N+6N5dNhScDXpw0trODZqTNUnGMOExDbqvHIqcIeYBMcvJoxx95yvMzX/9vOq4lhnfcUyjPupQK/Cy3UmzT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hAmZF7u8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C2DC19425;
	Fri, 24 Apr 2026 13:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038091;
	bh=GxzZn9hvUqhlQyf3eh9/FJQ6uZSy79UPMZWoDcQjcv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAmZF7u812ZVuVUUjkTqX7D8xv20mDJLc6wDQGzhQvKS1NjmngQphHxasltBCykmG
	 VKbJpJZMGvQRBKjo40Q+AW0H/HdUWgWqvTO7yB4dSflnVOwkGR2qbJCOZItriFCsg/
	 NdIP87CiVxXA0nB3FamlEt0bejUVUluGyoLNHANM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 20/55] kunit: configs: Enable all CRC tests in all_tests.config
Date: Fri, 24 Apr 2026 15:30:59 +0200
Message-ID: <20260424132434.269813208@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132430.006424517@linuxfoundation.org>
References: <20260424132430.006424517@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 347EC45F736
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240885-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunit.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@kernel.org>

commit 44ff3791d6295f7b51dd2711aad6a03dd79aef22 upstream.

The new option CONFIG_CRC_ENABLE_ALL_FOR_KUNIT enables all the CRC code
that has KUnit tests, causing CONFIG_KUNIT_ALL_TESTS to enable all these
tests.  Add this option to all_tests.config so that kunit.py will run
them when passed the --alltests option.

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20260314172224.15152-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/kunit/configs/all_tests.config |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -46,6 +46,8 @@ CONFIG_AUDIT=y
 
 CONFIG_PRIME_NUMBERS=y
 
+CONFIG_CRC_ENABLE_ALL_FOR_KUNIT=y
+
 CONFIG_SECURITY=y
 CONFIG_SECURITY_APPARMOR=y
 CONFIG_SECURITY_LANDLOCK=y



