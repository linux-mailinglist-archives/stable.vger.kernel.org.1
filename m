Return-Path: <stable+bounces-271393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T36NNgSbRmrEZwsAu9opvQ
	(envelope-from <stable+bounces-271393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:08:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7D66FB063
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:08:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=o4Q6+KOY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271393-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271393-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B191B34062C2
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49FC33B951;
	Thu,  2 Jul 2026 16:57:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8030C15A;
	Thu,  2 Jul 2026 16:57:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011426; cv=none; b=Nd72ItcVVH7NsIH/S7SacsymUoJuODZYqFZ6OkJRmN4NeKMyVWrZQFqFxiFDNIUG1KV44CQH0cNREU+IRsoC8sHCosOI3SrJHHS6Mi6fJT9pn2q4kDIHqvRcKdTjBm74jT+wom45ZFEGmrvFi6ALOjo8GNWO7a6KnKKoADOy+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011426; c=relaxed/simple;
	bh=cpDfpQvOXXi5JkIXAXpcEuhMRJu8PrtNR3SitnMngDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVHKzqjLMAUU6PYlqqp7FQAIjRCeAF9aE+hI/sYCi0pnBvCEL5ZAcBAUHlSbbh7W0fEM8gGKEe+RKfYX9238KzQOIEdR3dfighi0M1jwtfOCyFl3Ktxzkvcs0OeE0x53oXL99yLtK0hLzXzUBINt0m2+iCtl/N2CzCVjHnA6ze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o4Q6+KOY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6BC1F000E9;
	Thu,  2 Jul 2026 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011425;
	bh=i4sz7qdozYsL0iity4mKznHnBftqFuZsyT5H04qKnps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o4Q6+KOY8Vf73egSOdII7nyzT8x/6uxZdy3CsGdZF6HeI3XpQenIYGxpDJlhluePN
	 5KE3PxJcRjRnRsf3Dgev757ZbQ8bNz14bqsQ2tmQ0ldeM+fhxlMRsJVifsA9rvsSuc
	 2iTCoChopy9bsJB9d3ICojZFER5XachUWqSjUZ6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hem Parekh <hemparekh1596@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.18 105/108] ksmbd: fix out-of-bounds read in smb_check_perm_dacl()
Date: Thu,  2 Jul 2026 18:21:42 +0200
Message-ID: <20260702155114.289636817@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.110058792@linuxfoundation.org>
References: <20260702155112.110058792@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271393-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:hemparekh1596@gmail.com,m:linkinjeon@kernel.org,m:stfrench@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D7D66FB063

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hem Parekh <hemparekh1596@gmail.com>

commit 1ef06004ed4bd6d3ed8c840d9d1a376b66d4935b upstream.

The permission-check ACE walk in smb_check_perm_dacl() validates the ACE
header size and caps sid.num_subauth at SID_MAX_SUB_AUTHORITIES, but it
never checks that ace->size is actually large enough to contain
num_subauth sub-authorities before compare_sids() dereferences them.

CIFS_SID_BASE_SIZE covers the SID header up to but excluding the
sub_auth[] array, and offsetof(struct smb_ace, sid) is the ACE header,
so the existing guards only guarantee the 8-byte SID base, i.e. zero
sub-authorities. compare_sids() then reads ace->sid.sub_auth[i] for
i < min(local_sid->num_subauth, ace->sid.num_subauth). The local
comparison SIDs (sid_everyone, sid_unix_NFS_mode, and the id_to_sid()
result) always have at least one sub-authority, and an attacker controls
the ACE revision and authority bytes (which lie within the in-bounds SID
base), so they can match one of those SIDs and force the sub_auth read.

A crafted ACE with size == 16 and num_subauth >= 1 placed at the tail of
the security descriptor therefore causes a heap out-of-bounds read of up
to SID_MAX_SUB_AUTHORITIES * sizeof(__le32) bytes past the pntsd
allocation. The security descriptor is loaded by ksmbd_vfs_get_sd_xattr()
into a buffer sized exactly to the on-disk data (kzalloc(sd_size) in
ndr_decode_v4_ntacl()), so the read lands past the allocation. The
malformed descriptor can be stored verbatim via SMB2_SET_INFO (the DACL
is not normalised before being written to the security.NTACL xattr) and
the read fires on a subsequent SMB2_CREATE access check, making this
reachable by an authenticated client on a share that uses ACL xattrs.

Add the missing num_subauth-versus-ace_size check, mirroring the
identical guards already present in the sibling parsers parse_dacl() and
smb_inherit_dacl().

Fixes: d07b26f39246 ("ksmbd: require minimum ACE size in smb_check_perm_dacl()")
Cc: stable@vger.kernel.org
Signed-off-by: Hem Parekh <hemparekh1596@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smbacl.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1480,7 +1480,9 @@ int smb_check_perm_dacl(struct ksmbd_con
 			break;
 		aces_size -= ace_size;
 
-		if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES)
+		if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
+		    ace_size < offsetof(struct smb_ace, sid) + CIFS_SID_BASE_SIZE +
+			      sizeof(__le32) * ace->sid.num_subauth)
 			break;
 
 		if (!compare_sids(&sid, &ace->sid) ||



