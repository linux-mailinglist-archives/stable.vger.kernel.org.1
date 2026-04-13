Return-Path: <stable+bounces-236265-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOccEe4a3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236265-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:33:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B99FA3EF3F3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05457311D047
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E61288C30;
	Mon, 13 Apr 2026 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FvNKoSFG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2328CF5F;
	Mon, 13 Apr 2026 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096467; cv=none; b=fnT7n1IqW5shFyaludh6NnnZMSlq+F10toaTjoPFO2u1wbq8nnlkC+nYURlkX6liotLMbX56KEpYftWhex9yGRbzhcQrzCQp1fPm+1FbztmuvjTv+O9hkBoOaJMPDz7Z9uTAI503kv1abx9lfgIAK2DRPjA9xEeDldY9BHy0n/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096467; c=relaxed/simple;
	bh=/n1C6GT7xTPFVY+S3qW3VXCQ30EHxilKgmY5aYBveY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELdm1ECqRInuyV3I/uyhHqwadFl6Joggh3mfL/SxI0mYyJHG0aLjN3kPPg9QdP5REINMEoPBC2QO8DQ8gIdTWkI3CyZ+GxwoZ9IOZkygL32QzsrHKmXl4WZqn4/usPb/dfOLNUtJWn/zJpWwZIAcu7KfGmyJmENgiDsaNL1tV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FvNKoSFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544DAC2BCAF;
	Mon, 13 Apr 2026 16:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096467;
	bh=/n1C6GT7xTPFVY+S3qW3VXCQ30EHxilKgmY5aYBveY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FvNKoSFGOfkVbxKnzbhfErE6X9iXOvVsZ+dMhCWRFaabJ7hnUA1QM6zM/ECRCDuF0
	 1qV/v8HhCg8wqfZb5tPJAGtt4zANiEVxOW8J3RYtaDxRRzrVqXHtIluRbL/f1DL3XP
	 F/N/BlroRtHHJRTJdF2gZJho+8KemnJcNdEMFtCg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolas Schier <nsc@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.18 23/83] modpost: Declare extra_warn with unused attribute
Date: Mon, 13 Apr 2026 17:59:51 +0200
Message-ID: <20260413155731.887899772@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
References: <20260413155731.019638460@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236265-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: B99FA3EF3F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit deb4605671cfae3b2803cfbbf4739e7245248398 upstream.

A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
in clang under a new subwarning, -Wunused-but-set-global, points out an
unused static global variable in scripts/mod/modpost.c:

  scripts/mod/modpost.c:59:13: error: variable 'extra_warn' set but not used [-Werror,-Wunused-but-set-global]
     59 | static bool extra_warn;
        |             ^

This variable has been unused since commit 6c6c1fc09de3 ("modpost:
require a MODULE_DESCRIPTION()") but that is expected, as there are
currently no extra warnings at W=1 right now. Declare the variable with
the unused attribute to make it clear to the compiler that this variable
may be unused.

Cc: stable@vger.kernel.org
Fixes: 6c6c1fc09de3 ("modpost: require a MODULE_DESCRIPTION()")
Link: https://patch.msgid.link/20260325-modpost-extra_warn-unused-but-set-global-v1-1-2e84003b7e81@kernel.org
Reviewed-by: Nicolas Schier <nsc@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/mod/modpost.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -56,7 +56,7 @@ static bool allow_missing_ns_imports;
 
 static bool error_occurred;
 
-static bool extra_warn;
+static bool extra_warn __attribute__((unused));
 
 bool target_is_big_endian;
 bool host_is_big_endian;



