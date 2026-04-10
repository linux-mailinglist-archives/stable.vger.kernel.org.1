Return-Path: <stable+bounces-235643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGHiN74l2WmnmggAu9opvQ
	(envelope-from <stable+bounces-235643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:30:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DAC3DA697
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08502303AF36
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450963DBD6C;
	Fri, 10 Apr 2026 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkbujMNO"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE36D3191CE
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838358; cv=none; b=gz5G9d6bStZYfmClnKiRRww/AA4JncUGoHPuL9iYKo0zcv1OyIdsFP4B654z0cVg9Zu/KXbJ88wc9mk+OwrojDtXzdRSz/m5AM7Ml1v5g3CpD1SWM1Iw0tu5xAApE2Od6z3XIAtSkL70tJsR/4WjkS2ia678k53BkvFRhTnB1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838358; c=relaxed/simple;
	bh=WIgf06YVrt3i8IDBeTEXTOVKt6Ma5XHOJR3hB7Q6upw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWCX+q9Lv6ADW4RsUNE2P1uFkp7o596xihivm1MwRFO4wu4+7U+iw02S9ZEKXIQGisK6ON3q+RrMhy6rC0Ov0+FauXh5Jp2ed3TmXl0LavdkJoCHEJi9aT4SCLuY/3fpZBYWsltT5u3AxUP+rDKlECAByIc3rJEWkXbQBQBGqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkbujMNO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775838356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIgf06YVrt3i8IDBeTEXTOVKt6Ma5XHOJR3hB7Q6upw=;
	b=UkbujMNOyVjWAhcSpoLUibJ+FyHsVRYp3DQ7vt37t5PBrZCCjNKO8RHl0DqV1jxpUH9uFo
	untOV2TY7fz8/l9IgmOgMQlbqA6/pumBdujgTp9FKW5sJVkuIWv1BMXzP2XASY4x0zcJxQ
	QHDD8yA3ZU4ppQLPiuiqIxcXWBsOlSQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-uRPQk7QlOeyjSGPY8gCZmA-1; Fri,
 10 Apr 2026 12:25:50 -0400
X-MC-Unique: uRPQk7QlOeyjSGPY8gCZmA-1
X-Mimecast-MFC-AGG-ID: uRPQk7QlOeyjSGPY8gCZmA_1775838348
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A82C3183EED1;
	Fri, 10 Apr 2026 16:25:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.88])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F5B01800B7F;
	Fri, 10 Apr 2026 16:25:43 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: przemyslaw.kitszel@intel.com
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jacob.e.keller@intel.com,
	jtornosm@redhat.com,
	kohei.enju@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net v2 3/4] iavf: send MAC change request synchronously
Date: Fri, 10 Apr 2026 18:25:42 +0200
Message-ID: <20260410162542.209743-1-jtornosm@redhat.com>
In-Reply-To: <30d48647-8c1d-4683-ae9d-becb33cf8d4f@intel.com>
References: <30d48647-8c1d-4683-ae9d-becb33cf8d4f@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235643-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,google.com,lists.osuosl.org,redhat.com,gmail.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97DAC3DA697
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Przemek,

Thank you again for your comments.
I will try to include the new ones too in the next version.
In addition, I will analyze the suggested integration with existing
iavf_poll_virtchnl_msg() and possibly iavf_virtchnl_completion, but maybe
better in a new patch of the series as a refactoring.

Best regards
Jose Ignacio


