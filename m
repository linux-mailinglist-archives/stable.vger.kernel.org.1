Return-Path: <stable+bounces-254673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLk9O/hKF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:50:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BF75E9AD1
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3B23305E7C7
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E153B3BE3;
	Wed, 27 May 2026 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEBO5/8p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8F93B19D9;
	Wed, 27 May 2026 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911371; cv=none; b=MuMgj6aBkLKJKvM0Ju0sxZj2XGdkjCnSXoMd9lHp+WAdZNcnJgxFYsa4J04MrfVcDZPIaYX6jWF2Wwkst2ynQsCEFWLo4sYRDID+q/KnYy62FuIdzIBHt7C9GI9cka8VZo+Tn+eWL615WYN5X93WfOkjJbBXVBPg8ba7LhNd3ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911371; c=relaxed/simple;
	bh=6HGBQUynXtTgPBnjiHAvqpKYuuZYKXSuEOlvKVtskNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bps3cO1QeuE8Hz9enC+ibUsxa70TtNMcRvNtDZBtSkTUAsFGa5dGGYTAyiMd+/kguAdLM7jEkHrjV1uZNeLAWy2JW4Tdwbmw6qd2d3n40TmjMykh3IO7nSbEF26OSVQvWn20FkAEPDx1YJBFDOOHOWnHtiLNI/iWXvtx6SoR4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEBO5/8p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F16F1F000E9;
	Wed, 27 May 2026 19:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911370;
	bh=6HGBQUynXtTgPBnjiHAvqpKYuuZYKXSuEOlvKVtskNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JEBO5/8pb/iKu1btxAGuFGxUZVCOmiQaRbq2DraY80HqXgp4pUBfw0ZdNaOOvdHm0
	 tZXVMXtuzurRzPg8R2lD8SL1bW4vbMCTVMpS2Vp1xGD5nwCiir0UkMNuAwfhsnHrC/
	 z8ktwJaVmpI4UNrJnTCb/zNtc8oDPl/BrV7wh9JURGfcmQcxj0Zt/mO3rcxpfwGjT7
	 JYVPl//svJf5Yv/vID7zFFLk8DtLZug2me5jomBPLarxrPAhErgMPLf47kjN9LbOPK
	 szpFMqo7lzWoDi3W1hI87+YlqGTxxIS0EmAujypNaBvLNi6WJkz21mEinbPQ9s6Iiz
	 I0oXC4LI0y49Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	dwmw2@infradead.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	Joerg Roedel <jroedel@suse.de>,
	Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: Re: [PATCH 6.12] iommu/vt-d: Draining PRQ in sva unbind path when FPD bit set
Date: Wed, 27 May 2026 15:49:05 -0400
Message-ID: <20260527-agent5-item013-iommu@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526192401.80768-1-gyokhan@amazon.de>
References: <20260526192401.80768-1-gyokhan@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254673-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E4BF75E9AD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> commit cf08ca81d08a04b3b304e8fb4e052f323a09783d upstream.

Queued for 6.12.y, thanks.

--
Thanks,
Sasha

