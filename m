Return-Path: <stable+bounces-262689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JaHFJVCrKmrgugMAu9opvQ
	(envelope-from <stable+bounces-262689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 14:34:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06185671E37
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 14:34:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fusS4jyO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262689-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262689-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2978030BF804
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423923F871B;
	Thu, 11 Jun 2026 12:32:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7D3F6C3A
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 12:32:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181140; cv=none; b=YbP8p2/m0KyW/Da7Tlk76cEJD+QFRofVHhG4g9C7oeqbDIqcLEhgXV+bMBd/fS9UpGUmItS3PEm/VvQ3XFbL7L2niMSrfKbSDwjq201dXBUrdEDDpsTgKurjuhcnoN9RnkUeg0KuC/Tp5K6gZfYvloNDsB5DhGURchtcS4ZH4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181140; c=relaxed/simple;
	bh=BSx2REIDdYh6rBcLzILSd3dV8BAOIWvSwTx3IBfTmHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=id5nfYPNPTtuklMFVL07IrlSV0Oj6beWS++sGC1E/jTwdsUpvV8CIzsBZ5VSmueyEFr/hJ7s8wEaf6M1Ok767YA6wYEYZhjF0ywkvFmr2k4mOBa12hyTfW3rkmRS12V01jI9aINYsK75ZNT4oOYR7i+/dDSV44CBoux8aML8Z3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fusS4jyO; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9155183b42cso134025985a.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 05:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781181137; x=1781785937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLymrEZazNmQKknDX1QeqtCgPzdIbUvDepEeTIb67zo=;
        b=fusS4jyOa5zHNNzrdMeHlzjDsolfIbVNkICGkyClIIWsCwESgBqYtsHIEEU3x6HhGO
         0JPnrpiybvQ4cWf4I4/S9UO3IcosKCI3tCMZbOWEsZay2gGu4ra3Fy4Li/ImZIHagM6x
         FUlMWvSW/pjSYWc0cD9h0O7i8l9V6Woydhq4bG6BP6hXkifYqt5kNhmUpHI5uR+aoaT6
         oyregi29XXuDRDQG+KJEmyfIWqzYYK1bQrfeDJUemX3S53sqGS7T5j2MsBpYIxlfTpy4
         ndHOD4LMCD1+YoH45+iawFoZlNkbcay+eo70O/X0LGtmPDTT3pCIweHfVi5Ioe4WCsjM
         xaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781181137; x=1781785937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mLymrEZazNmQKknDX1QeqtCgPzdIbUvDepEeTIb67zo=;
        b=bTkGkPUwCaBqY6lKJJ57kRYAxMvnnNHJ1LlWph648yIYPsyKbAOVAf3SHLHN0usywH
         L7Wh4ZFP//DJPlEJiwq341Hg76p7GJzW6s7ptuSZ0GyDZJmDXAM93gGdbxVkdETXWhY5
         /5if/y2sLxF7Ip1DkgJjAcPFijsCTnNNRlFrEIZK1y4N7fraotwbPA/uKm9RXdjqjVmG
         YbqiXRYISnztajDRde3tVVnbSgG9LNtTYreZPYJf7FAICRiyiodhwhhe5I6TjF7Uzz9p
         0Rzmh8s1iNOyHKcHj20V/3pV3s6TPbuEmd7LgwtrI1fgV83yfYG/y+JOIY6bsDftP0EI
         n4vw==
X-Forwarded-Encrypted: i=1; AFNElJ8Pd+g9YqdjvDAVSF6/aRD8EkkptrUwe0PXnNGpy7uEV3g+nmIRfDjhgc8ehBndS4AN01boATM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEl417htz2wDhzPAiR9I3KenY09sn3O+Z+VIfnFxbF9wzKbrYe
	08Z90SqFIfzUMtUkM3GhN6+yiaE0kbXVyVquUviuRwxnva9EmnCAxkSK
X-Gm-Gg: Acq92OGD3ijXzn2ssIAMMnEi3nZe12YR/s5I0BOKIYMxlNL+4BIRflXGUzLwLNb7R99
	hxljSxcfDvFvTfffdUL3sw0IUdbERqA4x5EUv+oGLBpJ/R02YsCzZX+aL7EYIWZ15v6ynCFTcI+
	NpB4NTaPZ7x0/WTbRvzLKHLrcf+Dcdibb1YpRfjXJE5Jc7iIY/2J816hBbNkqMuY3wmrth1l28L
	LFnV3fM2gSqdvKWBxsD+9AcdmCRKsUqIEQr8ImFc/ZMN1LF81WRE12TYDX4ll+07CIEGAGoVQn/
	nHqZZm3VEa9GgHD84Gh3mLYMEatbVsXgB44sxQP565WPmT34NoLtFkFj9+OHggkO+lio/YW/G2O
	TLfW0DC4EinoW3kYswSvdZaVYq3HaAslRzcS/Tu2iKqYfafvw4oEAC4AZzBmnZdNzmPTqYS8hBd
	c9dO83gnAeoOlOzYDu9A9RmrM6gLYcds/r3vU+KlbictoOpF45qTn4FskdFApByKDSbgA0pp7+g
	ez7C8VOBTGskU3Z5UOohgcVOhjsKoQ=
X-Received: by 2002:a05:620a:440c:b0:910:c1ba:91d3 with SMTP id af79cd13be357-9160a841f7fmr283346285a.45.1781181136610;
        Thu, 11 Jun 2026 05:32:16 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160b02f758sm171220685a.36.2026.06.11.05.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:32:15 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org,
	linux-scsi@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] xen/scsiback: free unsubmitted command instead of double-putting it
Date: Thu, 11 Jun 2026 08:30:45 -0400
Message-ID: <20260611123046.2323342-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611123046.2323342-1-michael.bommarito@gmail.com>
References: <20260611123046.2323342-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262689-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jgross@suse.com,m:sstabellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:xen-devel@lists.xenproject.org,m:linux-scsi@vger.kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06185671E37

scsiback_get_pend_req() obtains a command tag and returns a
vscsibk_pend whose embedded se_cmd has only been memset to 0, so
its cmd_kref is 0; the se_cmd is initialised (kref_init() via
target_init_cmd()) only later, in scsiback_cmd_exec(), on the
successful VSCSIIF_ACT_SCSI_CDB path. The two error paths in
scsiback_do_cmd_fn() taken before the command is submitted -- a
failed scsiback_gnttab_data_map() and an unknown ring_req.act --
call transport_generic_free_cmd(&pending_req->se_cmd, 0), which
kref_put()s a refcount of 0. That underflows it ("refcount_t:
underflow; use-after-free") and, as the release function is not
run, leaks the command tag.

Impact: a pvSCSI guest can leak every command tag of a LUN's
session, stopping the LUN, by submitting requests with a bad
grant reference or an unknown request type; under panic_on_warn
the refcount underflow panics the host.

Add a helper that just returns the tag with target_free_tag() and
sends the error response. It frees the tag while the v2p reference
still pins the session, and snapshots the response fields
beforehand because freeing the tag can let another ring reuse the
pending_req slot.

Fixes: 2dbcdf33dbf6 ("xen-scsiback: Convert to percpu_ida tag allocation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Reproduced on a Xen dom0 (Linux 6.1.y) exporting a pvSCSI LUN to a guest.
A frontend that sends a single ring request with an unknown action type
drives scsiback_do_cmd_fn() into transport_generic_free_cmd() on the
never-initialised command and logs

  refcount_t: underflow; use-after-free
  WARNING: ... refcount_warn_saturate
   transport_generic_free_cmd+0x... [target_core_mod]
   scsiback_do_cmd_fn+0x... [xen_scsiback]
   scsiback_irq_fn+0x... [xen_scsiback]

from the vscsiif IRQ thread, and panics the dom0 under panic_on_warn.  The
failed grant-map path reaches the same free.  With this patch the same
request is answered with DID_ERROR and the tag is returned, with no
underflow.  These error paths are unchanged since 2dbcdf33dbf6, so mainline
is affected identically.

 drivers/xen/xen-scsiback.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index e33f95c91b096..f324732eba7f8 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -611,6 +611,25 @@ static void scsiback_disconnect(struct vscsibk_info *info)
 	xenbus_unmap_ring_vfree(info->dev, info->ring.sring);
 }
 
+/*
+ * Send the error response for a request that did not reach the target core
+ * and return its tag.  Free the tag before the response drops the v2p
+ * reference that keeps the session alive, and snapshot what the response
+ * needs since returning the tag can let the slot be reused.
+ */
+static void scsiback_resp_and_free(struct vscsibk_pend *pending_req,
+				   int32_t result)
+{
+	struct vscsibk_info *info = pending_req->info;
+	struct v2p_entry *v2p = pending_req->v2p;
+	struct se_session *se_sess = v2p->tpg->tpg_nexus->tvn_se_sess;
+	u16 rqid = pending_req->rqid;
+
+	target_free_tag(se_sess, &pending_req->se_cmd);
+	scsiback_send_response(info, NULL, result, 0, rqid);
+	kref_put(&v2p->kref, scsiback_free_translation_entry);
+}
+
 static void scsiback_device_action(struct vscsibk_pend *pending_req,
 	enum tcm_tmreq_table act, int tag)
 {
@@ -792,9 +811,8 @@ static int scsiback_do_cmd_fn(struct vscsibk_info *info,
 		case VSCSIIF_ACT_SCSI_CDB:
 			if (scsiback_gnttab_data_map(&ring_req, pending_req)) {
 				scsiback_fast_flush_area(pending_req);
-				scsiback_do_resp_with_sense(NULL,
-						DID_ERROR << 16, 0, pending_req);
-				transport_generic_free_cmd(&pending_req->se_cmd, 0);
+				scsiback_resp_and_free(pending_req,
+						       DID_ERROR << 16);
 			} else {
 				scsiback_cmd_exec(pending_req);
 			}
@@ -808,9 +826,7 @@ static int scsiback_do_cmd_fn(struct vscsibk_info *info,
 			break;
 		default:
 			pr_err_ratelimited("invalid request\n");
-			scsiback_do_resp_with_sense(NULL, DID_ERROR << 16, 0,
-						    pending_req);
-			transport_generic_free_cmd(&pending_req->se_cmd, 0);
+			scsiback_resp_and_free(pending_req, DID_ERROR << 16);
 			break;
 		}
 
-- 
2.53.0


