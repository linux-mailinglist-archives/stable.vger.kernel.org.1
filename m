Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AAA7BDFD3
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377149AbjJINea (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377146AbjJINea (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:34:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B9C94
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:34:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5DCC433C7;
        Mon,  9 Oct 2023 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858468;
        bh=2EAG0nqZ3Dek+SaBxAn5+IQNciDtEb2eqcdGviyH/ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7/x/U+tHqnJSVapVBB/JAxExpKaE559U96hwaOdnnwL1xVaxwfexK965dV9jC59o
         7icwgQF8NGoFEzDD941dNPrtdLn7yu/vJEd1AO+X3uZpCBVTaZDC5zcvCBYkLnqsJx
         9YfTgFm+kAi2DYeHWDsY0ENGhHehfjKWxoP7KiY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 105/131] NFS4: Trace state recovery operation
Date:   Mon,  9 Oct 2023 15:02:25 +0200
Message-ID: <20231009130119.630511529@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 511ba52e4c01fd1878140774e6215e0de6c2f36f ]

Add a trace point in the main state manager loop to observe state
recovery operation. Help track down state recovery bugs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Stable-dep-of: ed1cc05aa1f7 ("NFSv4: Fix a nfs4_state_manager() race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4state.c |  3 ++
 fs/nfs/nfs4trace.h | 93 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 01b1856705941..04aa8e34d1129 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -61,6 +61,7 @@
 #include "nfs4session.h"
 #include "pnfs.h"
 #include "netns.h"
+#include "nfs4trace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_STATE
 
@@ -2525,6 +2526,7 @@ static void nfs4_state_manager(struct nfs_client *clp)
 
 	/* Ensure exclusive access to NFSv4 state */
 	do {
+		trace_nfs4_state_mgr(clp);
 		clear_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
 		if (test_bit(NFS4CLNT_PURGE_STATE, &clp->cl_state)) {
 			section = "purge state";
@@ -2641,6 +2643,7 @@ static void nfs4_state_manager(struct nfs_client *clp)
 out_error:
 	if (strlen(section))
 		section_sep = ": ";
+	trace_nfs4_state_mgr_failed(clp, section, status);
 	pr_warn_ratelimited("NFS: state manager%s%s failed on NFSv4 server %s"
 			" with error %d\n", section_sep, section,
 			clp->cl_hostname, -status);
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 2295a934a154e..010ee5e6fa326 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -563,6 +563,99 @@ TRACE_EVENT(nfs4_setup_sequence,
 		)
 );
 
+TRACE_DEFINE_ENUM(NFS4CLNT_MANAGER_RUNNING);
+TRACE_DEFINE_ENUM(NFS4CLNT_CHECK_LEASE);
+TRACE_DEFINE_ENUM(NFS4CLNT_LEASE_EXPIRED);
+TRACE_DEFINE_ENUM(NFS4CLNT_RECLAIM_REBOOT);
+TRACE_DEFINE_ENUM(NFS4CLNT_RECLAIM_NOGRACE);
+TRACE_DEFINE_ENUM(NFS4CLNT_DELEGRETURN);
+TRACE_DEFINE_ENUM(NFS4CLNT_SESSION_RESET);
+TRACE_DEFINE_ENUM(NFS4CLNT_LEASE_CONFIRM);
+TRACE_DEFINE_ENUM(NFS4CLNT_SERVER_SCOPE_MISMATCH);
+TRACE_DEFINE_ENUM(NFS4CLNT_PURGE_STATE);
+TRACE_DEFINE_ENUM(NFS4CLNT_BIND_CONN_TO_SESSION);
+TRACE_DEFINE_ENUM(NFS4CLNT_MOVED);
+TRACE_DEFINE_ENUM(NFS4CLNT_LEASE_MOVED);
+TRACE_DEFINE_ENUM(NFS4CLNT_DELEGATION_EXPIRED);
+TRACE_DEFINE_ENUM(NFS4CLNT_RUN_MANAGER);
+TRACE_DEFINE_ENUM(NFS4CLNT_DELEGRETURN_RUNNING);
+
+#define show_nfs4_clp_state(state) \
+	__print_flags(state, "|", \
+		{ NFS4CLNT_MANAGER_RUNNING,	"MANAGER_RUNNING" }, \
+		{ NFS4CLNT_CHECK_LEASE,		"CHECK_LEASE" }, \
+		{ NFS4CLNT_LEASE_EXPIRED,	"LEASE_EXPIRED" }, \
+		{ NFS4CLNT_RECLAIM_REBOOT,	"RECLAIM_REBOOT" }, \
+		{ NFS4CLNT_RECLAIM_NOGRACE,	"RECLAIM_NOGRACE" }, \
+		{ NFS4CLNT_DELEGRETURN,		"DELEGRETURN" }, \
+		{ NFS4CLNT_SESSION_RESET,	"SESSION_RESET" }, \
+		{ NFS4CLNT_LEASE_CONFIRM,	"LEASE_CONFIRM" }, \
+		{ NFS4CLNT_SERVER_SCOPE_MISMATCH, \
+						"SERVER_SCOPE_MISMATCH" }, \
+		{ NFS4CLNT_PURGE_STATE,		"PURGE_STATE" }, \
+		{ NFS4CLNT_BIND_CONN_TO_SESSION, \
+						"BIND_CONN_TO_SESSION" }, \
+		{ NFS4CLNT_MOVED,		"MOVED" }, \
+		{ NFS4CLNT_LEASE_MOVED,		"LEASE_MOVED" }, \
+		{ NFS4CLNT_DELEGATION_EXPIRED,	"DELEGATION_EXPIRED" }, \
+		{ NFS4CLNT_RUN_MANAGER,		"RUN_MANAGER" }, \
+		{ NFS4CLNT_DELEGRETURN_RUNNING,	"DELEGRETURN_RUNNING" })
+
+TRACE_EVENT(nfs4_state_mgr,
+		TP_PROTO(
+			const struct nfs_client *clp
+		),
+
+		TP_ARGS(clp),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, state)
+			__string(hostname, clp->cl_hostname)
+		),
+
+		TP_fast_assign(
+			__entry->state = clp->cl_state;
+			__assign_str(hostname, clp->cl_hostname)
+		),
+
+		TP_printk(
+			"hostname=%s clp state=%s", __get_str(hostname),
+			show_nfs4_clp_state(__entry->state)
+		)
+)
+
+TRACE_EVENT(nfs4_state_mgr_failed,
+		TP_PROTO(
+			const struct nfs_client *clp,
+			const char *section,
+			int status
+		),
+
+		TP_ARGS(clp, section, status),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(unsigned long, state)
+			__string(hostname, clp->cl_hostname)
+			__string(section, section)
+		),
+
+		TP_fast_assign(
+			__entry->error = status;
+			__entry->state = clp->cl_state;
+			__assign_str(hostname, clp->cl_hostname);
+			__assign_str(section, section);
+		),
+
+		TP_printk(
+			"hostname=%s clp state=%s error=%ld (%s) section=%s",
+			__get_str(hostname),
+			show_nfs4_clp_state(__entry->state), -__entry->error,
+			show_nfsv4_errors(__entry->error), __get_str(section)
+
+		)
+)
+
 TRACE_EVENT(nfs4_xdr_status,
 		TP_PROTO(
 			const struct xdr_stream *xdr,
-- 
2.40.1



