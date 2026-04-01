Return-Path: <stable+bounces-232776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDa2I+8WzWmMZwYAu9opvQ
	(envelope-from <stable+bounces-232776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 15:00:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B1C37ADDB
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8FF4300899C
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4545407568;
	Wed,  1 Apr 2026 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="e2aWZAL0"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53D3B47DF;
	Wed,  1 Apr 2026 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048410; cv=none; b=Z6xTOLOt5QrfM8c7e46Bx3J9ATz/2VAooHC6oQ2/gi4yIswj4YdgU61jmNRz6+4AS/W3mWWzlMPLTXi1vZD/cuR+gySGZ6dBuYNI69tzudcQEXsvppeodBkq1NScag1hvVZbHDYbKZNHkKIbavBmNYc06uRqRvR8itQJRbTn2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048410; c=relaxed/simple;
	bh=sSBZQW9J3Pj5Ef2fYwWH3fpvKqzj1IsoW4puTUxOKxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJk4S0PeMAm/JhUhpsUNBvP35PjDv1HbWyU0RAZkYqNXMcg/0qKzybNdu2FrOt/Y+IBaLkhidQ5SEAgXLXd3PkeOzgxDBrhT271SBULZyopi5riGrGjXfv6QaRwsxgm341oCb4DvxeMn3A7PWO2cj6J5Jqy28jriQJsmkaSKsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=e2aWZAL0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sSBZQW9J3Pj5Ef2fYwWH3fpvKqzj1IsoW4puTUxOKxE=; b=e2aWZAL0l3xSw8DvVL4qdN0wGh
	tqYLr/s0nrQNTqJaO9vWRMolq0ChIhAa9no7hQhtMiacmfJYhWqXziu25k44/k7Lfjl1fYD+/hpDb
	lruv2f7t2RBb6q4Zds7jlk2UYpE3lPja0JCQdJyMaRf56hcq9J1ajJtLrGVYoW4kzhvSx1lzq+11A
	wHSfeM85knDgcxqk8M+BY0Jqa2u7V84usxgWF+Ldqs6YHoATiSOAYPOEkZ1rOqX0Nr3rg2Avt543Q
	E9GN4GovdjnbgiZV/cyOqD77D/E3XFwkdhlq/RqE249rRKe2ha+401EpcMs45v3ooJ+vwvqWmjkYq
	HLxLC3bw==;
Received: from 179-125-75-205-dinamico.pombonet.net.br ([179.125.75.205] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w7vAn-009xPN-17; Wed, 01 Apr 2026 14:59:53 +0200
Date: Wed, 1 Apr 2026 09:59:47 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Johnny Hao <johnny_haocn@sina.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+0584f746fde3d52b4675@syzkaller.appspotmail.com,
	syzbot+dd320d114deb3f5bb79b@syzkaller.appspotmail.com,
	Youngjun Lee <yjjuny.lee@samsung.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 5.15.y] media: uvcvideo: Mark invalid entities with id
 UVC_INVALID_ENTITY_ID
Message-ID: <ac0Ww-aoBRmDkSE5@quatroqueijos.cascardo.eti.br>
References: <20260401081048.2338697-1-johnny_haocn@sina.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401081048.2338697-1-johnny_haocn@sina.com>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-232776-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[sina.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[igalia.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.251];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,0584f746fde3d52b4675,dd320d114deb3f5bb79b,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,quatroqueijos.cascardo.eti.br:mid]
X-Rspamd-Queue-Id: 27B1C37ADDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

What about the followup fix 758dbc756aad ("media: uvcvideo: Use heuristic
to find stream entity")?

And what about 6.1? I don't see this at 6.1 yet.

Thanks.
Cascardo.

