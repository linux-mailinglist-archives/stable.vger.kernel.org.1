Return-Path: <stable+bounces-38581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C458A0F60
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588091C20DC1
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABE9146D49;
	Thu, 11 Apr 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jgGgSZoM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A09146A9D;
	Thu, 11 Apr 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830996; cv=none; b=H+FwyKrB4mgL1IzTK0NIWJEAcEB6L4JxL+QxPFdXTzXf57DaByHuD/OO6bXACGxGI8cRgWAB8wAATOpfjhuTPylhKcYzJ/qlsWFpjd9VOZaOYCrHJrJSjC+rTqcfiObsPffZnX/0UC8CZwF/6GOhmlnDCg1id3UKLzMkJr/sNck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830996; c=relaxed/simple;
	bh=8G4TDd/RO5GoPAXiKcIJP45TF6VqselMZOGteGO+s18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMsbAUGqIvM73LU/bEZq72doH3u7TYLSvBFouA3qlAY3GFuCn/1lOzs3zz9TbBUG2Z5/uj9IMi7voXjMHJ8zh5R/xk+IQqoOLY5bTJRgszCiyaVmzd+rMatbW2WqZbhuguyCV810M7RS9MCmsKG5nJDXVrzR4JLXzLJYlQPEvF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jgGgSZoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3F4C433F1;
	Thu, 11 Apr 2024 10:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830996;
	bh=8G4TDd/RO5GoPAXiKcIJP45TF6VqselMZOGteGO+s18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jgGgSZoM772QVsi7wO+rBJnDi56us6M1uPhlJjb9dXxv7PW7+nobApA6XKQ6AleeJ
	 YQKBtwXfe6xlB26aYV1IusgVVdPVBkouInMovS32ZPM69ORf/e1zWwgyBZqUvDqpdx
	 2CTHglPmQnX0ATRGzBeOm966S1DJ0+S8YFEYuFMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 151/215] selftests: reuseaddr_conflict: add missing new line at the end of the output
Date: Thu, 11 Apr 2024 11:56:00 +0200
Message-ID: <20240411095429.423353184@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

commit 31974122cfdeaf56abc18d8ab740d580d9833e90 upstream.

The netdev CI runs in a VM and captures serial, so stdout and
stderr get combined. Because there's a missing new line in
stderr the test ends up corrupting KTAP:

  # Successok 1 selftests: net: reuseaddr_conflict

which should have been:

  # Success
  ok 1 selftests: net: reuseaddr_conflict

Fixes: 422d8dc6fd3a ("selftest: add a reuseaddr test")
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/r/20240329160559.249476-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/reuseaddr_conflict.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/net/reuseaddr_conflict.c
+++ b/tools/testing/selftests/net/reuseaddr_conflict.c
@@ -109,6 +109,6 @@ int main(void)
 	fd1 = open_port(0, 1);
 	if (fd1 >= 0)
 		error(1, 0, "Was allowed to create an ipv4 reuseport on an already bound non-reuseport socket with no ipv6");
-	fprintf(stderr, "Success");
+	fprintf(stderr, "Success\n");
 	return 0;
 }



