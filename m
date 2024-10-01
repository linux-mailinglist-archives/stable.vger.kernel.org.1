Return-Path: <stable+bounces-78565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862BE98C47D
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C031C2347D
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295851CC899;
	Tue,  1 Oct 2024 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="QEOGC50N"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12C1CBE96
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803929; cv=none; b=tj7VDB2BQrayqm4PP3KQTE9W7KUtBBzSCePU6v/lNAgsY0Z+Gbs9vpSsGjBhp/61Edwep8MyS/Nq3Meg+C3dgeOr2ri808Z9lhj1vARpY7rGIVEfI4x5w3hoksOHGa6vMxFEqH/SsH5ayMP/I4C9c+9qdwyJrES4XE+OlNxylz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803929; c=relaxed/simple;
	bh=2rXJmCQImnyyQETslHEWVdgM3hwO32Sca6tGzmM6+ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urD7AnkZQVw+7mzUrPsuVkfZ8BGKwTTGIKsrmwVV29IxmY9jgC4qNaSr7AfTPqPxQP+OZFxACRmq1BmDF8zy1trh0oDHF/ahqS0eanaOxfGyvLYypj/pwOD6RKui1Utt/s/AvSkwn5iS3iI7kwjzee1GMNc9pr0yvYhP7dHKzfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=QEOGC50N; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2rXJmCQImnyyQETslHEWVdgM3hwO32Sca6tGzmM6+ck=;
	b=QEOGC50N6aSuGtSzL0KJHFsJma4N4CIuN+KvdyfKNcNt1+PJeZsEyqEHjsDMC2p9yGNAr7
	3ff3Lax8E5WAW1tRv8Sb8h7bMB3FbJwg1tV9xiXqUNwjaxY3eumqDkOuB4cGZ0cTXbuAV1
	4bERfseIfIqAZ+2MepnUW0vDWZnZSYA=
Received: from g8t13017g.inc.hp.com (hpi-bastion.austin2.mail.core.hp.com
 [15.72.64.135]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-VTQl0jrzNuGHA5hkj1vccQ-1; Tue, 01 Oct 2024 13:32:05 -0400
X-MC-Unique: VTQl0jrzNuGHA5hkj1vccQ-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g8t13017g.inc.hp.com (Postfix) with ESMTPS id 0381260008BE;
	Tue,  1 Oct 2024 17:32:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id E70511E;
	Tue,  1 Oct 2024 17:32:01 +0000 (UTC)
From: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: qin.wan@hp.com,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	mika.westerberg@linux.intel.com,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>,
	Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Subject: [PATCH 6.6 01/14] thunderbolt: Fix debug log when DisplayPort adapter not available for pairing
Date: Tue,  1 Oct 2024 17:30:56 +0000
Message-Id: <20241001173109.1513-2-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001173109.1513-1-alexandru.gagniuc@hp.com>
References: <20241001173109.1513-1-alexandru.gagniuc@hp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

From: Gil Fine <gil.fine@linux.intel.com>

[ Upstream commit 6b8ac54f31f985d3abb0b4212187838dd8ea4227 ]

Fix debug log when looking for a DisplayPort adapter pair of DP IN and
DP OUT. In case of no DP adapter available, log the type of the DP
adapter that is not available.

Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/thunderbolt/tb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c5e10c1d4c38..6fc300edad68 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1311,13 +1311,12 @@ static void tb_tunnel_dp(struct tb *tb)
 =09=09=09continue;
 =09=09}
=20
-=09=09tb_port_dbg(port, "DP IN available\n");
+=09=09in =3D port;
+=09=09tb_port_dbg(in, "DP IN available\n");
=20
 =09=09out =3D tb_find_dp_out(tb, port);
-=09=09if (out) {
-=09=09=09in =3D port;
+=09=09if (out)
 =09=09=09break;
-=09=09}
 =09}
=20
 =09if (!in) {
--=20
2.45.1


