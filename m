Return-Path: <stable+bounces-8836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9429082051A
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38C61C20A2E
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1779A79D8;
	Sat, 30 Dec 2023 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W8vtyqj6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D529B79DE;
	Sat, 30 Dec 2023 12:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104E8C433C8;
	Sat, 30 Dec 2023 12:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937888;
	bh=ktZITLM9vIuLKC0Cz+AcKMDpBj3A9xekoiBviundXlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8vtyqj6gnaeYTg702rmODuucUZfP6y+z3AsT2LJrUuU6sXFO+DPb5rYPobzljy1g
	 cEZi1IswlegIq/yJfNTHeNJ+qMK7mPK50Ff6p4O843gzFuRHVqsSXkbi38rNogAB46
	 Tv7M6YxGysXLeUbUXpnfY94AoeSB3wPk9Ei/RXqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.6 101/156] wifi: cfg80211: fix certs build to not depend on file order
Date: Sat, 30 Dec 2023 11:59:15 +0000
Message-ID: <20231230115815.670881851@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Johannes Berg <johannes.berg@intel.com>

commit 3c2a8ebe3fe66a5f77d4c164a0bea8e2ff37b455 upstream.

The file for the new certificate (Chen-Yu Tsai's) didn't
end with a comma, so depending on the file order in the
build rule, we'd end up with invalid C when concatenating
the (now two) certificates. Fix that.

Cc: stable@vger.kernel.org
Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: fb768d3b13ff ("wifi: cfg80211: Add my certificate")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/certs/wens.hex |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/wireless/certs/wens.hex
+++ b/net/wireless/certs/wens.hex
@@ -84,4 +84,4 @@
 0xf0, 0xc7, 0x83, 0xbb, 0xa2, 0x81, 0x03, 0x2d,
 0xd4, 0x2a, 0x63, 0x3f, 0xf7, 0x31, 0x2e, 0x40,
 0x33, 0x5c, 0x46, 0xbc, 0x9b, 0xc1, 0x05, 0xa5,
-0x45, 0x4e, 0xc3
+0x45, 0x4e, 0xc3,



