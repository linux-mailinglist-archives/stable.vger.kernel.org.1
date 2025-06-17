Return-Path: <stable+bounces-152936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537CADD186
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4A11896E3A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85032ECD31;
	Tue, 17 Jun 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J6htfzUR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312811CBA;
	Tue, 17 Jun 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174320; cv=none; b=q6lKRVHbJ6m7mjTWc264Vq4fm0zEH6mgpELFcBGnQHZ3+HCNFie1LW1ECZqnSI2C865nWoA1aDvllbwoyFYSYz+U7HOgqOQdk0T8UUO7NvA0sBb10dRADKClRDJxmGbARpdQVJ8TzCws+4GCfIcEbssY86VykZk+z6FF88iy4Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174320; c=relaxed/simple;
	bh=Ciia5kjpjm9/0kJ8mCE5rJ+z2TEDuN2YYAEH+1dkjdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQ4U/pqLv9/GEpmWXzCr90kIyxhcxD9rm9d4q14Tqj/UqXOQdJo78mRRxvrJj3t1MynAQDoED0ERYVPoXk50Ahy3Ff9EJO/Hg9ns7aLUOlfLOPDsNDrbIlK3Wy13GzEDo/QQ+2wPEU+dr4QJzktec34Ui8WSRhA95EXGzdkDcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J6htfzUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8567C4CEE3;
	Tue, 17 Jun 2025 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174320;
	bh=Ciia5kjpjm9/0kJ8mCE5rJ+z2TEDuN2YYAEH+1dkjdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J6htfzUR2dtoxprHacSDlpGXwWqCssrBC33+tQXOw8r9Pniybwzp0CN8mulLR6kIo
	 8V3e7VbNSPYodhseG+ta/0GeQQs9NJaG04G2ymwavU8XwQBDRMB1Q/+CC8JINWDGhe
	 tU/8YomTjM2ZKtj6e+rKbyZQdg4y3HllPx/DA8Ao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 049/356] PM: wakeup: Delete space in the end of string shown by pm_show_wakelocks()
Date: Tue, 17 Jun 2025 17:22:44 +0200
Message-ID: <20250617152340.208225109@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit f0050a3e214aa941b78ad4caf122a735a24d81a6 ]

pm_show_wakelocks() is called to generate a string when showing
attributes /sys/power/wake_(lock|unlock), but the string ends
with an unwanted space that was added back by mistake by commit
c9d967b2ce40 ("PM: wakeup: simplify the output logic of
pm_show_wakelocks()").

Remove the unwanted space.

Fixes: c9d967b2ce40 ("PM: wakeup: simplify the output logic of pm_show_wakelocks()")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://patch.msgid.link/20250505-fix_power-v1-1-0f7f2c2f338c@quicinc.com
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/wakelock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 52571dcad768b..4e941999a53ba 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -49,6 +49,9 @@ ssize_t pm_show_wakelocks(char *buf, bool show_active)
 			len += sysfs_emit_at(buf, len, "%s ", wl->name);
 	}
 
+	if (len > 0)
+		--len;
+
 	len += sysfs_emit_at(buf, len, "\n");
 
 	mutex_unlock(&wakelocks_lock);
-- 
2.39.5




