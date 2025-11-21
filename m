Return-Path: <stable+bounces-196320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA00C79E5B
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71BE0381EE3
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9B7347BC6;
	Fri, 21 Nov 2025 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i4z5w2cQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A152DCF55;
	Fri, 21 Nov 2025 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733172; cv=none; b=hrdM5IAr5VbTP1HMKIG9Q462IijQJa5uGgi1LmqyC/UunMqqh5m0A/2ABYhtSWcdW/CEpHyCqw6VaR/8RjO/xJfQ4AyBhgWGn/lsrzkrKEWpYxytRkshNoEwRATb1k5tGZombj5C1H0u+dZKajj6SekjijQY3JnOl47mk7CQmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733172; c=relaxed/simple;
	bh=jjd+QWFKDXc2TH55UK05l50TZ9N+ASCqE/uznQwb1wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phOnKgqWzpAm8lrDOKiFdyW8pkditSo6cNeKA7EfoDHChImFkp0M9yKsOftaIBIAUHntLS0DYM+NRha/wJsNCRte3hVZy4qCpD6vg6HRFFNZyLhoe3Cz4VMbuZU+v6ySM1L8V95Vg7BaMVSAfYXZU+mHbQK/DQjom9Eejc1SDXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i4z5w2cQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C9BC4CEF1;
	Fri, 21 Nov 2025 13:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763733171;
	bh=jjd+QWFKDXc2TH55UK05l50TZ9N+ASCqE/uznQwb1wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i4z5w2cQO9Dth17vihU7EzRFoeQlJ4hmq3ToKKZtfn20Sc6QlKgAWtc29z3gtAgyQ
	 XVOA72uLA7+iUuo1OsZjNQyQ8yGPDUlaPH88R+cvjS255t73+6RntywEpjk+eXRPx9
	 YEqtDLQpUfOnvD8UNPR4wa+jHrQWAOoKKkA+dQ6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.6 376/529] selftests: netdevsim: set test timeout to 10 minutes
Date: Fri, 21 Nov 2025 14:11:15 +0100
Message-ID: <20251121130244.405004126@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130230.985163914@linuxfoundation.org>
References: <20251121130230.985163914@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

commit afbf75e8da8ce8a0698212953d350697bb4355a6 upstream.

The longest running netdevsim test, nexthop.sh, currently takes
5 min to finish. Around 260s to be exact, and 310s on a debug kernel.
The default timeout in selftest is 45sec, so we need an explicit
config. Give ourselves some headroom and use 10min.

Commit under Fixes isn't really to "blame" but prior to that
netdevsim tests weren't integrated with kselftest infra
so blaming the tests themselves doesn't seem right, either.

Fixes: 8ff25dac88f6 ("netdevsim: add Makefile for selftests")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/drivers/net/netdevsim/settings |    1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/settings

--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/settings
@@ -0,0 +1 @@
+timeout=600



