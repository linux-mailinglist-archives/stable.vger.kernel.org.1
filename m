Return-Path: <stable+bounces-270342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5holL3EARmrWHgsAu9opvQ
	(envelope-from <stable+bounces-270342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 08:08:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 182106F3B05
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 08:08:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=jGPGAkrW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270342-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270342-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B29F13007B33
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 06:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F22369D5D;
	Thu,  2 Jul 2026 06:07:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1581374A0B
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 06:07:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972475; cv=none; b=EzTOZJDidyV+uWwgW0bSKjQaCLd+MmX9Cr0t600bVD+XgrYpT1K37eD4ocXE0Nc4c6qGHmywtWq0OQ0ERXfMXCh3CwmvxScvarUVCO9LTEuLFBDS3F9c+L1M8xtyll3i6fl4omMghKADrjvaMwnPJrsXzHaR8TPYj/Tc0UsPQgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972475; c=relaxed/simple;
	bh=fzGMVpwottawy8SBQS2Dx2K5HqtSwxxWch8ZeUwm1xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdV63DD5DEQvArHUENoaktie+me6AKaU+X60KpRFDOFrBc1HQks+Qe6bE44WU0EH+QVNUEwOLpubBrxDQADl1LgfHF8W+boRsSpFPGoV9c+LT0bt/n8DQ53WIyCJGu7MyB6MUcXmCIEt86NE8ugIZUL0M95JKhYdRbBVkQu1Cd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGPGAkrW; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782972472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4UvuXefX8yd84GaG25xUb95oI2RF2HujmNeaEeoIYs=;
	b=jGPGAkrWmM+ZkiJJUfGPaQk4ghcdxTZKxhOOrP62BaeAngFYJrRjW8rbl4h5lVOUAFyqK0
	FIxSL1uSBW47JzmWDPkE20YRBECAq4htqcdgF4a7gR1EpNIRsDiEFa9UHrC2XKbY0jtONK
	kCnkiQN8RYdcHDpxWJUZyte/AzfDu6M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-M9B-jmFmO5ib1ycgkmwL0w-1; Thu,
 02 Jul 2026 02:07:51 -0400
X-MC-Unique: M9B-jmFmO5ib1ycgkmwL0w-1
X-Mimecast-MFC-AGG-ID: M9B-jmFmO5ib1ycgkmwL0w_1782972470
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9801418C1054;
	Thu,  2 Jul 2026 06:07:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8963E3000C2F;
	Thu,  2 Jul 2026 06:07:46 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jtornosm@redhat.com
Cc: ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ath12k: fix NULL pointer dereference in rhash table destroy
Date: Thu,  2 Jul 2026 08:07:44 +0200
Message-ID: <20260702060744.478850-1-jtornosm@redhat.com>
In-Reply-To: <20260615112103.601982-1-jtornosm@redhat.com>
References: <20260615112103.601982-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270342-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:ath12k@lists.infradead.org,m:jjohnson@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 182106F3B05

Gentle ping on this patch.

This fixes a NULL pointer dereference during driver unbind that
crashes the kernel when initialization failed partially. The crash
is 100% reproducible when unbinding after an initialization failure.

This is particularly critical for VM environments with VFIO passthrough.

Regarding the concern from v1 about preferring symmetric init/deinit:
I understand the preference for unwinding init failures at each stage.
However, implementing full symmetric cleanup would require extensive
refactoring of multiple error paths across ath12k_core_start(),
ath12k_dp_alloc(), and related initialization functions.

The NULL check approach provides a safe, minimal fix that:
1. Prevents the crash without changing complex init logic
2. Follows the same pattern used elsewhere in the kernel for
   conditional cleanup (e.g., other rhashtable users)
3. Has been tested and validated in the failing scenario

I've addressed the guard(mutex) feedback from v1 in this v2.

If Qualcomm engineering prefers a different approach, I'm happy to
revise, but no alternative has been suggested since the v1 discussion.

Please let me know if there are any other concerns.

Thanks

Best regards
Jose Ignacio


