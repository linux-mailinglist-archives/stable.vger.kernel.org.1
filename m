Return-Path: <stable+bounces-210599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MPSOQzfb2n8RwAAu9opvQ
	(envelope-from <stable+bounces-210599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 21:01:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA2F4AEFE
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 21:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 281568A1EA2
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0C747DD5B;
	Tue, 20 Jan 2026 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atdmEiwz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663347DD61;
	Tue, 20 Jan 2026 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937711; cv=none; b=g8asWGDD7pwT93GC/FMcYWxRynf+LWr9tQRDr3w+NEA+YPwrgozvyV1F79LvQ7VsWwERscS4pgOm9eOchmcayLGGewedLw9WT8gRFJFwuOX9s+0Eyxyq9lEWjpfgt+iF21XY02kMy6JQL82lAgH9oeHE/Rrrn1moJiYJn7v6Ejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937711; c=relaxed/simple;
	bh=pJlsRew5eftP2Jsy6yH4nSxgh1li+FzDMGa47OhgI6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6Oavx5v3w/v3gauN3kTZYmmHuHLan8DB3Ex7AeYfkkFd8PCOHiOGuIVWMlyAKuY9e/KILerlxQTCUmXZnGggX6B0AzPv+dsvFcGd60Whe7MBDN6gmp9OApNjC245wEyaOY+OYAp4/1OlFgQxNOF7LNZBU3pV6MopcJp3vhMw2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atdmEiwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7086C19422;
	Tue, 20 Jan 2026 19:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768937709;
	bh=pJlsRew5eftP2Jsy6yH4nSxgh1li+FzDMGa47OhgI6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atdmEiwzQUF3JaW1ecAAfXzXtuFk5NawHGbxEvNmT7YmvgI+93i++dD4bE/aIt22w
	 Ks3zmHA2fCPWNirWLxCHdKd7N4w/qx7v9YIiHs6kszK5lymCmBAhzr5FOzYicSQ892
	 gHfhOjrah22a4HetSBeBX3h61JVkU3+3eo7sy+TthYFYXXeh4mljfGYYYIec1ktukg
	 DlUKt09PGEfaAFytIDdCF1MXqAJfWvlp+NHGNjt2cClkJjAXyOWJVCkSvfLR7x++4H
	 0WrtauT6aZfZ+L2zK6nf/mHHO01KdOdb8dc/Yvx9zUZYTyQ5us133p2Ih7iPAIOR+u
	 /V4Pz22fJ1Cfg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] ASoC: simple-card-utils: Check device node before overwrite direction
Date: Tue, 20 Jan 2026 14:34:51 -0500
Message-ID: <20260120193456.865383-8-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120193456.865383-1-sashal@kernel.org>
References: <20260120193456.865383-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210599-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,msgid.link:url,nxp.com:email,renesas.com:email]
X-Rspamd-Queue-Id: ADA2F4AEFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 22a507d7680f2c3499c133f6384349f62f916176 ]

Even the device node don't exist, the graph_util_parse_link_direction()
will overwrite the playback_only and capture_only to be zero. Which
cause the playback_only and capture_only are not correct, so check device
node exist or not before update the value.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://patch.msgid.link/20251229090432.3964848-1-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The commit seems to be describing a new patch to be analyzed. Based on
my full analysis, let me now synthesize my evaluation:

## ANALYSIS SUMMARY

### 1. COMMIT MESSAGE ANALYSIS

The commit message describes a bug where:
- When a device node doesn't exist (is NULL), the
  `graph_util_parse_link_direction()` function still overwrites
  `playback_only` and `capture_only` to zero (false)
- This causes incorrect behavior when these flags should remain as they
  were set by previous calls

The commit has:
- **Acked-by:** from the subsystem maintainer (Kuninori Morimoto)
- **Signed-off-by:** from the maintainer (Mark Brown)

### 2. CODE CHANGE ANALYSIS

**The Bug:**
Looking at the function:
```c
void graph_util_parse_link_direction(struct device_node *np,
                    bool *playback_only, bool *capture_only)
{
    bool is_playback_only = of_property_read_bool(np, "playback-only");
    bool is_capture_only  = of_property_read_bool(np, "capture-only");

    if (playback_only)
        *playback_only = is_playback_only;
    if (capture_only)
        *capture_only = is_capture_only;
}
```

When `np` is NULL:
1. `of_property_read_bool(NULL, ...)` returns `false` (since NULL node
   has no properties)
2. The function unconditionally overwrites `*playback_only = false` and
   `*capture_only = false`

**Call Pattern (from simple-card.c and audio-graph-card.c):**
```c
graph_util_parse_link_direction(top,    &playback_only, &capture_only);
graph_util_parse_link_direction(node,   &playback_only, &capture_only);
graph_util_parse_link_direction(cpu,    &playback_only, &capture_only);
graph_util_parse_link_direction(codec,  &playback_only, &capture_only);
```

The intent is hierarchical: if `top` sets `playback_only = true`, it
should remain true unless a lower-level node explicitly overrides it.
But if `cpu` or `codec` is NULL, the current code wrongly resets
`playback_only` to false.

**The Fix:**
```c
- if (playback_only)
+   if (np && playback_only)
        *playback_only = is_playback_only;
- if (capture_only)
+   if (np && capture_only)
        *capture_only = is_capture_only;
```

Adding `np &&` check prevents the function from overwriting the values
when `np` is NULL.

### 3. CLASSIFICATION

- **Bug fix:** Yes, clearly fixes a logic error
- **Security:** No security implications
- **Feature addition:** No

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed:** 2 (very minimal)
- **Files touched:** 1
- **Complexity:** Very low - adding a simple NULL check
- **Risk:** Very low - defensive programming that only affects behavior
  when np is NULL, which is already an edge case

### 5. USER IMPACT

- **Who is affected:** Users of ASoC simple-card and audio-graph-card
  drivers
- **Severity:** Audio routing could be incorrect (playback-only or
  capture-only configuration not being honored)
- **Visibility:** Users with device trees that set `playback-only` or
  `capture-only` on higher-level nodes where some lower-level nodes
  don't exist

### 6. STABILITY INDICATORS

- **Acked-by:** Kuninori Morimoto (maintainer of the code)
- **Signed-off-by:** Mark Brown (ASoC subsystem maintainer)

### 7. DEPENDENCY CHECK

- The function exists in stable trees starting from v6.10 (introduced in
  commit d29351e8c20d61)
- The fix applies cleanly and has no dependencies on other commits

### 8. FINAL ASSESSMENT

This is a clear, minimal, and well-reviewed bug fix that:
1. Fixes a real bug that causes incorrect audio configuration
2. Is small and surgical (2-line change with simple NULL check)
3. Has low regression risk (only affects edge case of NULL np)
4. Has been reviewed and acked by the appropriate maintainers
5. Would apply cleanly to stable trees (v6.10+) where this function
   exists

The fix is small, surgical, and meets all stable kernel criteria.

**YES**

 sound/soc/generic/simple-card-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 355f7ec8943c2..bdc02e85b089f 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -1179,9 +1179,9 @@ void graph_util_parse_link_direction(struct device_node *np,
 	bool is_playback_only = of_property_read_bool(np, "playback-only");
 	bool is_capture_only  = of_property_read_bool(np, "capture-only");
 
-	if (playback_only)
+	if (np && playback_only)
 		*playback_only = is_playback_only;
-	if (capture_only)
+	if (np && capture_only)
 		*capture_only = is_capture_only;
 }
 EXPORT_SYMBOL_GPL(graph_util_parse_link_direction);
-- 
2.51.0


