Return-Path: <stable+bounces-223920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGICA+H9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B503824A535
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3BE2304EEB2
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B40D36EA89;
	Tue, 10 Mar 2026 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3CYy+cJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77C248F73;
	Tue, 10 Mar 2026 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141056; cv=none; b=ZV8AYlWZhAKnqOByGtOM0K1DQjdj95RqiD0/W3ttzVVdoMuidqbQbCgjoeJXL7LoytNYvctib1aS5WFHKUOg4/Juy4bY8WSTW1CroTJnzdl5BUdVDg6Jb/B8EFmTFGQTe53Q3CffeGf565mRqAvBu56bxLEpWSOjJpDY8OgEFog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141056; c=relaxed/simple;
	bh=cWW9eFof961L9aB0guzCzhLkPs5ubIyNdwZ3bHGZUxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XILpm1sP6r8DjZswJ11ykLxaqrMyCmQPwYzyvXKgAUybqlcSflZLWnTukcWIF5auCygPvJk/grekCi0F77YqHKf65CvJEX++8mRE4dKPAoeMuHetQWqoxBnqw6aaPtiEHdN/zqzAzSMMu1MI031j2phke7cxi6CzAus5h/muFjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3CYy+cJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955CDC2BC86;
	Tue, 10 Mar 2026 11:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141056;
	bh=cWW9eFof961L9aB0guzCzhLkPs5ubIyNdwZ3bHGZUxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3CYy+cJGFZ7mxVBAy1mzlB79xOPhlgx/csDrxa8Eg5G8sLdYrwo511LnEO0bI+td
	 JeYsdR/431DrNdGaXbnWKERp3mJRo8ntNhzC50Bh8yJ/ChO2xD3e5c76489FMOAKfN
	 vRk6w23LCTMW3IQPVsNM2WDs9uNG4L9VrUPzgNWTkAFptgvZtZiWqwM21fW608Juug
	 t/aQ53zbQ8PlHFHnkYWEjKpVxbAirI1kH89XKYhKBC+kRT4GxGVEwQVYhz9n2xUj/2
	 BGfyULM4MXEszXgUegWuD/APwfkeeI5u4OaYXS62aQQw+x4aZm5QBqCpKxhpbLSj/w
	 cL1anlteUyqig==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 055/311] zloop: check for spurious options passed to remove
Date: Tue, 10 Mar 2026 07:01:42 -0400
Message-ID: <dff55384c7890ca8f8392b528f767f2d48d4ffcf.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B503824A535
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223920-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lst.de:email,kernel.dk:email]
X-Rspamd-Action: no action

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3c4617117a2b7682cf037be5e5533e379707f050 ]

Zloop uses a command option parser for all control commands,
but most options are only valid for adding a new device.  Check
for incorrectly specified options in the remove handler.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zloop.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index ae9bf2a85c21c..9e3bb538d5fcf 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1174,7 +1174,12 @@ static int zloop_ctl_remove(struct zloop_options *opts)
 	int ret;
 
 	if (!(opts->mask & ZLOOP_OPT_ID)) {
-		pr_err("No ID specified\n");
+		pr_err("No ID specified for remove\n");
+		return -EINVAL;
+	}
+
+	if (opts->mask & ~ZLOOP_OPT_ID) {
+		pr_err("Invalid option specified for remove\n");
 		return -EINVAL;
 	}
 
-- 
2.51.0


