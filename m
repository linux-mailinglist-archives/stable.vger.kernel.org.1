Return-Path: <stable+bounces-212700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJVtOaCPemmz7wEAu9opvQ
	(envelope-from <stable+bounces-212700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:37:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95228A9A75
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A76A30238DB
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 22:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D32D344046;
	Wed, 28 Jan 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOidNRKD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE51DE3A4;
	Wed, 28 Jan 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639641; cv=none; b=CN5fJyxpnrPIia8JD2L6rqaT74UG/tUyeo697X2UiDlArhQfOQJvS9E4vRdNhnFqcTMawfe6LDjcSV++sDRjKztMZvBXj1fb2EB0EwY8GnlMSbOqFf73uxKEkaSh53ITSTO1jnnSt3U6kN4EQe+A9+n2YL1qwrJMBvuUfn2ED18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639641; c=relaxed/simple;
	bh=4WPF0RWd/+xw+ffbBSv0gvLKr2HM/4sbMFAx5UJIYNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnOVbuPDYGh7Nq1RS+R1a4avw0W6xUb9Z5hce9kc+LDAX2CqPJy+1TQD0Rsf4e3wFMZOpLJpi6OgqeGop3s0fTBQnFAwe9E513laubGoTv/DjMwWiJCTELY3Ea1Vj63BnlBixX2luFkPappFksfBChl6MGuCmqeR+ipd5rrjFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOidNRKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF50C4CEF1;
	Wed, 28 Jan 2026 22:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769639640;
	bh=4WPF0RWd/+xw+ffbBSv0gvLKr2HM/4sbMFAx5UJIYNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOidNRKDZzQnwHheHoHJMk05fevG2uX2QybQtwC7fq3AU42VbYOTuGJU08/8ZLdap
	 Sq6JM2Q+2uD/pUq3zs08Hzc6RQZssXymzp5p3NiG5kbOcWEl8MYpNZWGehbx2DTBcQ
	 HDBowqdxRTMBPOtpANjQ80+GF/K6cEXsri13UzfZGo85P47kxy9TmqQYA5fkTxBEHK
	 E+VP9sae46wc7/uC+GMgbM1pmle2PUAJAwCQrZKEmNCW26dybtHgSQ3lwpEc4KCL+p
	 KiNqmbnYRtc2Xf6wql6dMkVFepZXU7HPVtiCVIVuglHJLZv3j2L9jpHFpIYaEBWsBh
	 hiS6DyNS4B4Fw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.6] regmap: maple: free entry on mas_store_gfp() failure
Date: Wed, 28 Jan 2026 17:33:13 -0500
Message-ID: <20260128223332.2806589-15-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128223332.2806589-1-sashal@kernel.org>
References: <20260128223332.2806589-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212700-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 95228A9A75
X-Rspamd-Action: no action

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit f3f380ce6b3d5c9805c7e0b3d5bc28d9ec41e2e8 ]

regcache_maple_write() allocates a new block ('entry') to merge
adjacent ranges and then stores it with mas_store_gfp().
When mas_store_gfp() fails, the new 'entry' remains allocated and
is never freed, leaking memory.

Free 'entry' on the failure path; on success continue freeing the
replaced neighbor blocks ('lower', 'upper').

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Link: https://patch.msgid.link/20260105031820.260119-1-kaushlendra.kumar@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

### SUMMARY

**What the commit fixes:**
A memory leak in `regcache_maple_write()` where the allocated `entry`
block is not freed when `mas_store_gfp()` fails. This is a clear
resource leak bug.

**Why it matters to stable users:**
- Memory leaks affect system stability over time, especially on long-
  running embedded systems that commonly use regmap
- Under memory pressure scenarios, this leak compounds the problem
- regmap is core infrastructure used by many hardware drivers

**Stable kernel criteria assessment:**
1. ✅ **Obviously correct**: The fix follows standard kernel error
   handling patterns - allocate, try to use, free on failure
2. ✅ **Fixes a real bug**: Memory leak is a real, user-visible issue
3. ✅ **Important issue**: Memory leaks can lead to system
   instability/OOM
4. ✅ **Small and contained**: ~8 lines changed in a single file, single
   function
5. ✅ **No new features**: Pure bug fix
6. ✅ **Clean backport**: Self-contained fix with no dependencies

**Risk vs Benefit:**
- **Risk**: Very low - the change only affects the error path of
  `mas_store_gfp()` failure
- **Benefit**: Fixes a memory leak in widely-used infrastructure code
- The logic is straightforward and the fix is obviously correct

**Affected versions:**
- The regcache-maple.c file was introduced in v6.4
- Applicable to stable trees: 6.4.y, 6.6.y (LTS), and newer

**Concerns:**
- None - this is a textbook stable backport candidate

**YES**

 drivers/base/regmap/regcache-maple.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 2319c30283a6d..9cf0384ce7b95 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -95,12 +95,13 @@ static int regcache_maple_write(struct regmap *map, unsigned int reg,
 
 	mas_unlock(&mas);
 
-	if (ret == 0) {
-		kfree(lower);
-		kfree(upper);
+	if (ret) {
+		kfree(entry);
+		return ret;
 	}
-	
-	return ret;
+	kfree(lower);
+	kfree(upper);
+	return 0;
 }
 
 static int regcache_maple_drop(struct regmap *map, unsigned int min,
-- 
2.51.0


