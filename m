Return-Path: <stable+bounces-233490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANmKHoeU1GknvgcAu9opvQ
	(envelope-from <stable+bounces-233490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 07:22:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CECC63A9E3B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 07:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4183303E48C
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 05:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2A7271450;
	Tue,  7 Apr 2026 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDFHSwlX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D23325701
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539301; cv=none; b=N3Eh+4IROFMtQvmwzIqJ5D4knl6fj8lHxIo8PbXmrdkRIAIdXcMdhwpDGh7/XfYkw09AH7M8beN4M4kGuMYK4Li7oxLgRAEAWhf1DSK08HJz24A8S4G5DeWyi6HnsJutmF2c500PVJnPmO6UHG7lsBKHyqUgUkU83xgH9CVj9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539301; c=relaxed/simple;
	bh=J0khTmXx+mH8KMAAu7/0Jhz0WYYqPaYIpbG+MFI9hGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX4JRt46nVp4KzXwnc0cfHoycJlOBuGBlZ6euJOrdzOsqIaYz02Itl3dKX383tFW1zWZVM0jzG9i4G3wDqVksXrSVoJMfy7djwJY27EkLedxfaB0UnpVtu1vYMbMnc9OUpeXpUfV7RdKqfV1zbII4Hb7vrGiacrecj9gypGMzMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDFHSwlX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775539299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0khTmXx+mH8KMAAu7/0Jhz0WYYqPaYIpbG+MFI9hGs=;
	b=SDFHSwlX3aUkVHJ6t2UaeMyvwz9Mfxf4CiMHKELVsBy87vf2Yokgikzai78n5jARF1yBlV
	4LdKqpuAvIiKBNP4PGNuiNwei+2PXH4nP519X/2e687pvrO/NDDadTiKZ1nNaQ8ZBVFNV8
	2o2mWlcXGHYjoam0JDwnx3upUNKOSRM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-8nzXMfqUMq6feDKfT0MdUQ-1; Tue,
 07 Apr 2026 01:21:36 -0400
X-MC-Unique: 8nzXMfqUMq6feDKfT0MdUQ-1
X-Mimecast-MFC-AGG-ID: 8nzXMfqUMq6feDKfT0MdUQ_1775539294
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3729218002CB;
	Tue,  7 Apr 2026 05:21:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8500300019F;
	Tue,  7 Apr 2026 05:21:29 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kohei@enjuk.jp
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net 3/3] iavf: drop netdev lock while waiting for MAC change completion
Date: Tue,  7 Apr 2026 07:21:28 +0200
Message-ID: <20260407052128.207856-1-jtornosm@redhat.com>
In-Reply-To: <adOjGCms-5PBuNte@x1>
References: <adOjGCms-5PBuNte@x1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-233490-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CECC63A9E3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kohei,

Thank you for your help and reference.
I will try to do it synchronously with the netdev lock held as you say.

Best regards
Jose Ignacio


