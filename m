Return-Path: <stable+bounces-67336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AB594F4F2
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E130B1F218EC
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C86183CA6;
	Mon, 12 Aug 2024 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBi0s/BZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BB01494B8;
	Mon, 12 Aug 2024 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480594; cv=none; b=IKIfnwv9P1qmj4zqIagB6/ErOr/bNxVv2ljriP7lnhdd4A/X6L8HZmu1YhS6uki7hM5Bi1pzER6fgjaoj3FLf5hhr9awUUcEcJWaWQrosu0c6OuBBY2XLIZAI8In1jTR4212QAbmA/eDZ1E60DLMFBkvS4R9nkxRkxLWXL2i7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480594; c=relaxed/simple;
	bh=YLUYXgMRyzc86B8fauXS79i3x94fyTqnnMB3r6SmnVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqPz2HhlJr51Ur2zYJ11gKkHrAByTbB98QnZvL+QNuvmn++BfafotSz0Tcjv3txlWHT5pdHnywUk8TzT5CRNiphkOFmWBqfsB3oe4D1X10+u2P5I2LI0YGjv0jwiFzEtmqUuzjWVJwvOBVYeLxcb4cVJq//49uw/ZyYqih6aqt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBi0s/BZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762D0C32782;
	Mon, 12 Aug 2024 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723480593;
	bh=YLUYXgMRyzc86B8fauXS79i3x94fyTqnnMB3r6SmnVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XBi0s/BZm5ITcegjFVbWH9/Fbi6rXbdPHvHO/7BLJ/BRZMSfTicrN4ZBu1vJ4bzMu
	 Or7YlLVQgZAkizSTY/QzvQFwLcAGcQ7qbQ4BJ0qrqKFqRItYezralBwkSfB8McrAe3
	 QNRerP75c/KtKnX/KWq61cS9XuWEDRMMfoPKNU6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lyude Paul <lyude@redhat.com>,
	Harry Wentland <hwentlan@amd.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 6.10 243/263] drm/dp_mst: Skip CSN if topology probing is not done yet
Date: Mon, 12 Aug 2024 18:04:04 +0200
Message-ID: <20240812160155.836931521@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
References: <20240812160146.517184156@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wayne Lin <Wayne.Lin@amd.com>

commit ddf983488c3e8d30d5c2e2b315ae7d9cd87096ed upstream.

[Why]
During resume, observe that we receive CSN event before we start topology
probing. Handling CSN at this moment based on uncertain topology is
unnecessary.

[How]
Add checking condition in drm_dp_mst_handle_up_req() to skip handling CSN
if the topology is yet to be probed.

Cc: Lyude Paul <lyude@redhat.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240626084825.878565-3-Wayne.Lin@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -4069,6 +4069,7 @@ static int drm_dp_mst_handle_up_req(stru
 	if (up_req->msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
 		const struct drm_dp_connection_status_notify *conn_stat =
 			&up_req->msg.u.conn_stat;
+		bool handle_csn;
 
 		drm_dbg_kms(mgr->dev, "Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: %d\n",
 			    conn_stat->port_number,
@@ -4077,6 +4078,16 @@ static int drm_dp_mst_handle_up_req(stru
 			    conn_stat->message_capability_status,
 			    conn_stat->input_port,
 			    conn_stat->peer_device_type);
+
+		mutex_lock(&mgr->probe_lock);
+		handle_csn = mgr->mst_primary->link_address_sent;
+		mutex_unlock(&mgr->probe_lock);
+
+		if (!handle_csn) {
+			drm_dbg_kms(mgr->dev, "Got CSN before finish topology probing. Skip it.");
+			kfree(up_req);
+			goto out;
+		}
 	} else if (up_req->msg.req_type == DP_RESOURCE_STATUS_NOTIFY) {
 		const struct drm_dp_resource_status_notify *res_stat =
 			&up_req->msg.u.resource_stat;



