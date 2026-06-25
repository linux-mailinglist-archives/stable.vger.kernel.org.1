Return-Path: <stable+bounces-268316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DzrmIc7zPGqtuwgAu9opvQ
	(envelope-from <stable+bounces-268316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:24:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 220FE6C430E
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:24:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kiDTg4Ns;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268316-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268316-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7B5C30AE492
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126C237F00D;
	Thu, 25 Jun 2026 09:19:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACBE378D68;
	Thu, 25 Jun 2026 09:19:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379151; cv=none; b=CPwS07dtZsZJomEMHz5AIHVqbQ+xxkAKWl15YaTs/uLyIkbS+hjr0wfuedOgjXsuUxWYzcKTj2msU/lm39lu+kLW0+IzD5xjKpSApssEdtRwrZrfBnF13OLi8TSLFMEIY6f7GpkUc0eEetcDi7mYwGtQbuQxCIhQIfc4/m6EBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379151; c=relaxed/simple;
	bh=L2sCHNBArFECZu32wDNGqOQ7ezC0d75AGZsPyq/Vh7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cS0Q4eHWx0YC7pw3WPojhpvw6Jlj5pJ2oM3wmBN37hcp5XKYFCc0gOGRPwJ5nLKwAYRrmbPYJ4PnQFvocinNOa5lcg8H6gne57F+PeNB4NIZa5z/h9pRbxZqoKVcrxprVv0roMOotcZEgrVYHz5AtlQgabTltIrMDpWa+CaiDfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiDTg4Ns; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B091F000E9;
	Thu, 25 Jun 2026 09:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782379150;
	bh=PX3gHaNl+RrkqI/2n6IzyNkbaa8O+J8H4fP3FFUzniA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kiDTg4NsexmH7Y55xAAMfod0mhd5ne698Q2UXdGQmJ3aas3ewPdalsfloRBMovyH8
	 0YWkFbHMHK9zje/dXWc7the4YydDeqwWtffh2zss/s3ffEDHXAkLBoFIwefKum0rtY
	 Yh/LPUDs+KkWFUiqjNHRfloIolm6IhRjHCxXFjRhGWuuYz0xIr2NoD879Xkxi3SCSr
	 O8XKlo7rfzq5eDzY4FE4SugJhxh3SWi/iO7puA2CP0HyzZS8PKmiV+gM/l4q8WZwTS
	 2KjsKeUhww/fAbfxHHLKtoO7sK64EDOOc9pxZhnr6ugsJuzr+xmg1ppGges2CMzEaf
	 SEysaG+p0Iyig==
From: Simon Horman <horms@kernel.org>
To: sam@bynar.io
Cc: Simon Horman <horms@kernel.org>,
	david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: nci: fix uninit-value in the RF discover/activated NTF handlers
Date: Thu, 25 Jun 2026 10:18:29 +0100
Message-ID: <20260625091828.1170615-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623234126.214667-1-sam@bynar.io>
References: <20260623234126.214667-1-sam@bynar.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sam@bynar.io,m:horms@kernel.org,m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268316-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 220FE6C430E

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
nfc: nci: fix uninit-value in the RF discover/activated NTF handlers

This zero-initialises the on-stack nci_rf_discover_ntf and
nci_rf_intf_activated_ntf structs in the RF discover and interface
activated NTF handlers so that the technology- and activation-specific
unions read back as zero when the corresponding length fields are zero.

Link: https://lore.kernel.org/netdev/20260623172109.1105965-2-horms@kernel.org/

>  - activated: with rf_tech_specific_params_len == 0 the same union is read
>    via nci_target_auto_activated(); with activation_params_len == 0 the
>    activation_params union is read by nci_store_ats_nfc_iso_dep() into
>    ndev->target_ats.

[Low]
Does the third scenario in this paragraph match the code?

Looking at nci_store_ats_nfc_iso_dep():

    static int nci_store_ats_nfc_iso_dep(struct nci_dev *ndev,
                         const struct nci_rf_intf_activated_ntf *ntf)
    {
        ndev->target_ats_len = 0;

        if (ntf->activation_params_len <= 0)
            return NCI_STATUS_OK;

        if (ntf->activation_params.nfca_poll_iso_dep.rats_res_len > NFC_ATS_MAXSIZE) {
        ...

The function returns NCI_STATUS_OK before any access to the
activation_params union when activation_params_len is 0, so the union
is not read in that case.

The sibling nci_store_general_bytes_nfc_dep() has the same early return
on activation_params_len <= 0.

The two rf_tech_specific_params_len == 0 cases listed earlier in the
commit message do match the code (nci_add_new_protocol() and
nci_target_auto_activated() unconditionally pass
&ntf.rf_tech_specific_params even when rf_tech_specific_params_len is
0), and the KMSAN trace quoted in the commit message only mentions the
nci_add_new_protocol() path.

The ntf = {} change still looks correct and necessary for the
rf_tech_specific_params union. Could the third bullet be dropped or
adjusted so the commit message reflects only the paths that actually
read uninitialised bytes?

