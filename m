Return-Path: <stable+bounces-122691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918E1A5A0C7
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBD73AC66C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A6222FAF8;
	Mon, 10 Mar 2025 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cFETYHph"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB317CA12;
	Mon, 10 Mar 2025 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629221; cv=none; b=ejmUvezVrAyCfSqBlTMWSf1X19ujCBkB2JGnHAdTdfMcmoTdZzmft3FY7NHALwZZvT++qogq5IGA0UWb+xsAiQoVxlwJG3lfZXKTks7kTaIFbFQ28ylu9be6OP0gaEz+ye5MrOPTRH4npOFTvW3U5nhMpdZOeiaqgSyywOWw/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629221; c=relaxed/simple;
	bh=UQXlsoacyhPtXQNPxu5+9BxZgAqmkp/ASav0WzOm43I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izjaGoOE+P6nqDXPEzNk+ZKyTExUtu7JyijgZeOG1ptRLuwk1vqPP8Y9x2RiLp7jZVXJ1YglJILHTnUk0VM92/0AjnYNRNVdsfkxUVYVxB7ecAmErtE6KAO7D8f4onm+NSH0bWmoBBw6K+XEgjq0dS35p8Ve/aKpsyXvxyC87G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cFETYHph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295ECC4CEE5;
	Mon, 10 Mar 2025 17:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629221;
	bh=UQXlsoacyhPtXQNPxu5+9BxZgAqmkp/ASav0WzOm43I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFETYHphKv7+gEKm+lVeWR5DPVIGKXMD57oOkEuPlbmUtreU9OfOcwVuIfZqB0t86
	 iDIXXHju0Ndqfp15BW8ZWQRhlwOnUuugMUfc9jGtePbM2v8L1pcJXWinQcdQyk6hF7
	 ma2iAsBH8VUgFHHKrJCcg1bnP6K1hF3V/WYjutTM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 187/620] NFSD: Reset cb_seq_status after NFS4ERR_DELAY
Date: Mon, 10 Mar 2025 18:00:33 +0100
Message-ID: <20250310170553.016037205@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit 961b4b5e86bf56a2e4b567f81682defa5cba957e upstream.

I noticed that once an NFSv4.1 callback operation gets a
NFS4ERR_DELAY status on CB_SEQUENCE and then the connection is lost,
the callback client loops, resending it indefinitely.

The switch arm in nfsd4_cb_sequence_done() that handles
NFS4ERR_DELAY uses rpc_restart_call() to rearm the RPC state machine
for the retransmit, but that path does not call the rpc_prepare_call
callback again. Thus cb_seq_status is set to -10008 by the first
NFS4ERR_DELAY result, but is never set back to 1 for the retransmits.

nfsd4_cb_sequence_done() thinks it's getting nothing but a
long series of CB_SEQUENCE NFS4ERR_DELAY replies.

Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4callback.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1202,6 +1202,7 @@ static bool nfsd4_cb_sequence_done(struc
 		ret = false;
 		break;
 	case -NFS4ERR_DELAY:
+		cb->cb_seq_status = 1;
 		if (!rpc_restart_call(task))
 			goto out;
 



