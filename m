Return-Path: <stable+bounces-155551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BF6AE4280
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C683B898B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B1A24BD00;
	Mon, 23 Jun 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lkdO3xf/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4C219E0;
	Mon, 23 Jun 2025 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684720; cv=none; b=X9lh6+BnVj9XaHCrtcS8Dr+e3XDwntWKZPPCh1k57UNh1b9+KmI68azk+ecASM6Rdxl83zGgP3LT8AnMYHvFmlphF4k6CT6HWivJtnZeYYBk3BfgfFfkbNCj5qdMf8+dwNSVf6Sc9EkVD+JHWuNQon13AuybNSquxolXF7IIYsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684720; c=relaxed/simple;
	bh=9ljnX3PWmwgZfNNlPSP7/4CgiiTktTfFMGs7PZg6AFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGLyNZL7zWR0x3hcUBZZnyejmQyvsjpau2h4POQAAtf5FDRFaSWlyNl71iZsYuIhj3K3RbXMsfpQQEIQMLA5yLd4fPPxsGhEhsTROwFq7J9nWzR0OrFm02SzPpxYa/eKN6UdhcoFVT7jSNocauVgPtUrH8QaiDHA8unva/5064o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lkdO3xf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051A6C4CEEA;
	Mon, 23 Jun 2025 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684720;
	bh=9ljnX3PWmwgZfNNlPSP7/4CgiiTktTfFMGs7PZg6AFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkdO3xf/dYRuSr3gyQMKCcGmKDXh8Tef8+4O7sbNQxJTNzW7gxfvScFFAHkprpg5d
	 PHFfuFFteey47Z/mdi1VbJ1hZ7N/TLg6TebZ9WByMhqd6HNUODK+vSaQvII8i0LQsm
	 SfC6NBxGvEh93ZYY1AWtDcVZBS3zsxyJq4aDZ7EY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 015/222] PM: wakeup: Delete space in the end of string shown by pm_show_wakelocks()
Date: Mon, 23 Jun 2025 15:05:50 +0200
Message-ID: <20250623130612.358838831@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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




