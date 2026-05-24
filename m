Return-Path: <stable+bounces-254036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4POTJC0YE2oi7gYAu9opvQ
	(envelope-from <stable+bounces-254036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:24:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 114085C2D78
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1768930094E5
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E13998AB;
	Sun, 24 May 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOpv6Ad+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1A38F259
	for <stable@vger.kernel.org>; Sun, 24 May 2026 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779636265; cv=none; b=R0ipXUKmsFw6QfTGlMBIM03g2RLFjSNVIwhWWdfgUetGzLigZ13M1Vgd+aLOpc5Glr4KS7ePwiXAtx3W3cfPkngj3y8r6sgUVC2so+XAdvjPzCWz7QaYPagh++QE2dURoRKjiCV0iTfQniS/zP6zp+86CA2A+OSnm3+UfweId5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779636265; c=relaxed/simple;
	bh=hETfygV+ofhieLyH/mxzdWPxbats9pJ8Wib7L6JPz8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeRmrXPa+wA03qmZl0oeRz8Y+GCiDWcJwe66y5xSSBqn3tgvmt/7Uz6P/w/bXb8rVJTP9DtH6Cyc13RmoWB01wc0kYkEeuwD36bJ2sRev3zm81yfjDYFox7uhHr9NpHvyJCrMAb16OLDywDKwPX7QSoFbRNEqjGjGkoRhNfw5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOpv6Ad+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCDE1F00A3A;
	Sun, 24 May 2026 15:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779636263;
	bh=oQpkikdYyAbn90+OUa9y1GRpzDMATwuN9yy7jlvrbgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KOpv6Ad+K4DQybnXbAmHnMGXB2zIy3vhU0r1Jq3ExnRywElSy1ayVANCNaxjLST5u
	 ah6HfdN9/399yCd+TU+xKgkabM3g4IAYi62Hgu48PeRwvynrXnFMYIOqlQMkkTDtB5
	 08e3bbISsDcwp6amO34MwaXA2s2ed92lW1mOW/5HCRbuAumBIHv/dEi0Gn5LZwT7Os
	 6KhVIKYig0xnpc7Z+h3zSd7iAjmUCFfwSkDKHidOz5P3I0e35/Zb9sOQwTipjaS4aW
	 b6GUbz56lw1nYu1CMuGe2jG/BOuvzagYlgJlB5Ft1hBmUZMSKV5Y0Ed9DwKZ2hlHSs
	 9UWTcs8auQTZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-stable <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: Linux 6.12.91 / build breakage / perf cgroup: Update metric leader in evlist__expand_cgroup
Date: Sun, 24 May 2026 11:24:16 -0400
Message-ID: <20260524150046.agent5-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9e585f6c-84e9-4b2e-9899-6770bd2c42fe@mailbox.org>
References: <9e585f6c-84e9-4b2e-9899-6770bd2c42fe@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,mailbox.org];
	TAGGED_FROM(0.00)[bounces-254036-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 114085C2D78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> So either revert these two commits, drop them, or also backport
> 137359b7895f61cd07fcdbaf9d195567bde8cc85 ?

Went with the revert path on 6.12 as 137359b7 is a larger non-stable refactor
that I'd rather not pull in just to satisfy a build prerequisite. 7cfcd01f33fc
had two newer dependents (the duration_time fix and the python parse_events
addition) that conflicted with reverting it alone, so I chained the reverts to
keep the tree buildable. This re-introduces the perf cgroup UAF that
c9ef786c0970 was fixing - if the perf folks would prefer to backport the
missing prereqs (d2f3ecb0 + 137359b7) instead, happy to swap approaches.

-- 
Thanks,
Sasha

