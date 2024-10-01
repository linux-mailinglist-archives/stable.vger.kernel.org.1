Return-Path: <stable+bounces-78574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA6D98C497
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CDF1C2381C
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A401CEADF;
	Tue,  1 Oct 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="foh8QRdN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838841CDFDD
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803941; cv=none; b=GxmXwoXQ/73bShPLlJrOQiTmQWLUAttgvPLkZSNbYrv6of+2qYsNLLdnqnV+fwPYOB7U9bs+Kui/WhAAuveKAnak73QL9dOWAkCmIu6w9PivzXDv5HhDZ89TqZnPe+2ln/czTGzbjGP7eV7aRQzxreRs9QA47Ln9BDKHoEAXR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803941; c=relaxed/simple;
	bh=s6/akAZsgWqiuMk26sEf6V9ItVqhVmu5+dG+4vYNaXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azu9D71MonRafoiThOBg8Dwq+orBKSefYaKAO2FBYoYpk0TtYkJfQI0UdUt4jjuGFd2lgElICph+1/RWuH5JFBGkfVhGpLhzwJwybqA4Yi0gTSUTv9pZwysQW9JX3MgbB6em5+Y8SavxnFOTxhBGtkp9458j6Aj+U4G7boGEiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=foh8QRdN; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pq/Dm2clE4lZ83DOiVWYmNMrV36eWwjNAXhOWGGYXak=;
	b=foh8QRdNk422SJ1Ia8qOfeucQi8UpqrEVF0lhhBw3C8/onuNH8Am7cuXZFpuETwxwps1d3
	f6nYcW81Oiik/kLrWOMPHy2OV8mWgF0ca+7e1eB6bdAT5ez94LJkHSvMscpycM95RaEzEj
	GmK01svyTCuyxaw7IMvnXxANiWhu0x4=
Received: from g8t13016g.inc.hp.com (hpifallback.mail.core.hp.com
 [15.72.64.134]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-XyXImHsdPT-O_3v_vPRZnw-1; Tue, 01 Oct 2024 13:32:17 -0400
X-MC-Unique: XyXImHsdPT-O_3v_vPRZnw-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g8t13016g.inc.hp.com (Postfix) with ESMTPS id 7362F600021C;
	Tue,  1 Oct 2024 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 1371A18;
	Tue,  1 Oct 2024 17:32:14 +0000 (UTC)
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
	Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Subject: [PATCH 6.6 10/14] thunderbolt: Introduce tb_for_each_upstream_port_on_path()
Date: Tue,  1 Oct 2024 17:31:05 +0000
Message-Id: <20241001173109.1513-11-alexandru.gagniuc@hp.com>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 956c3abe72fb6a651b8cf77c28462f7e5b6a48b1 ]

This is useful when walking over upstream lane adapters over given path.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/thunderbolt/tb.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 6d66dd2a3ab0..4cd5f48e3dee 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1076,6 +1076,21 @@ static inline bool tb_port_use_credit_allocation(con=
st struct tb_port *port)
 =09for ((p) =3D tb_next_port_on_path((src), (dst), NULL); (p);=09\
 =09     (p) =3D tb_next_port_on_path((src), (dst), (p)))
=20
+/**
+ * tb_for_each_upstream_port_on_path() - Iterate over each upstreamm port =
on path
+ * @src: Source port
+ * @dst: Destination port
+ * @p: Port used as iterator
+ *
+ * Walks over each upstream lane adapter on path from @src to @dst.
+ */
+#define tb_for_each_upstream_port_on_path(src, dst, p)=09=09=09\
+=09for ((p) =3D tb_next_port_on_path((src), (dst), NULL); (p);=09\
+=09     (p) =3D tb_next_port_on_path((src), (dst), (p)))=09=09\
+=09=09if (!tb_port_is_null((p)) || !tb_is_upstream_port((p))) {\
+=09=09=09continue;=09=09=09=09=09\
+=09=09} else
+
 int tb_port_get_link_speed(struct tb_port *port);
 int tb_port_get_link_generation(struct tb_port *port);
 int tb_port_get_link_width(struct tb_port *port);
--=20
2.45.1


