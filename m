Return-Path: <stable+bounces-80536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640B598DDE5
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2481F25D4E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049211D14FB;
	Wed,  2 Oct 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PYvj2Vq/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E661D14F3;
	Wed,  2 Oct 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880659; cv=none; b=d8vcL1b6HZGPbImCdoK5Z4FwoWhwXBEtJkkV8fYjx8QBLN3fNi01RDa17KEKc70tniyGxEowfenPgUFxT7Cbq34j/6qVY7/2o0fQjTpo2vwq2n5cWQ7rlUAJJ/o3WXX/6cbhG7R7rT0RclY6wne0Afk+iQbtYCULLt7W+YehgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880659; c=relaxed/simple;
	bh=dobRiKZnsTlHRDb50+ZohRXbv8Ev/tq0auVVcOfc2yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWn4sUEkLycI86whttBipGINAdND5AD4MgF4AC5jZlLUigGdGXzLGo7wJ3m8wVfLQ3Ftl+w+uEcOzyXNZDhS8gxEdix0/msGCp8Ia7QCuG7amzQKDyEsiaJZO6aLQghzh5gOYkSTr6p8HjTwKG431WikIpVnv7/Q1u/nDueekko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PYvj2Vq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FA7C4CEC2;
	Wed,  2 Oct 2024 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880659;
	bh=dobRiKZnsTlHRDb50+ZohRXbv8Ev/tq0auVVcOfc2yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYvj2Vq/mVKGyK00pXBY79T9cr431W2fSNUHAEP7L8uhIr4xJ4wZsN42LnxjhnfYW
	 SSI/vFMYncbDcGhOyTUa7s+tl0RIvOvCtIa/9iD/VS9HPhtZmgvfNVAhIn7xHzLFdz
	 g1lex9fgXiGKRU+rMkQfDBWzbIpY/BUUTsWxt3Nw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"qin.wan@hp.com, andreas.noever@gmail.com, michael.jamet@intel.com, mika.westerberg@linux.intel.com, YehezkelShB@gmail.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandru Gagniuc" <alexandru.gagniuc@hp.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Qin Wan <qin.wan@hp.com>,
	Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Subject: [PATCH 6.6 503/538] thunderbolt: Use tb_tunnel_dbg() where possible to make logging more consistent
Date: Wed,  2 Oct 2024 15:02:22 +0200
Message-ID: <20241002125812.295154636@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit fe8a0293c922ee8bc1ff0cf9048075afb264004a ]

This makes it easier to find out the tunnel in question. Also drop a
couple of lines that generate duplicate information.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/tunnel.c |   65 +++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -614,8 +614,9 @@ static int tb_dp_xchg_caps(struct tb_tun
 
 	in_rate = tb_dp_cap_get_rate(in_dp_cap);
 	in_lanes = tb_dp_cap_get_lanes(in_dp_cap);
-	tb_port_dbg(in, "maximum supported bandwidth %u Mb/s x%u = %u Mb/s\n",
-		    in_rate, in_lanes, tb_dp_bandwidth(in_rate, in_lanes));
+	tb_tunnel_dbg(tunnel,
+		      "DP IN maximum supported bandwidth %u Mb/s x%u = %u Mb/s\n",
+		      in_rate, in_lanes, tb_dp_bandwidth(in_rate, in_lanes));
 
 	/*
 	 * If the tunnel bandwidth is limited (max_bw is set) then see
@@ -624,8 +625,9 @@ static int tb_dp_xchg_caps(struct tb_tun
 	out_rate = tb_dp_cap_get_rate(out_dp_cap);
 	out_lanes = tb_dp_cap_get_lanes(out_dp_cap);
 	bw = tb_dp_bandwidth(out_rate, out_lanes);
-	tb_port_dbg(out, "maximum supported bandwidth %u Mb/s x%u = %u Mb/s\n",
-		    out_rate, out_lanes, bw);
+	tb_tunnel_dbg(tunnel,
+		      "DP OUT maximum supported bandwidth %u Mb/s x%u = %u Mb/s\n",
+		      out_rate, out_lanes, bw);
 
 	if (in->sw->config.depth < out->sw->config.depth)
 		max_bw = tunnel->max_down;
@@ -639,13 +641,14 @@ static int tb_dp_xchg_caps(struct tb_tun
 					     out_rate, out_lanes, &new_rate,
 					     &new_lanes);
 		if (ret) {
-			tb_port_info(out, "not enough bandwidth for DP tunnel\n");
+			tb_tunnel_info(tunnel, "not enough bandwidth\n");
 			return ret;
 		}
 
 		new_bw = tb_dp_bandwidth(new_rate, new_lanes);
-		tb_port_dbg(out, "bandwidth reduced to %u Mb/s x%u = %u Mb/s\n",
-			    new_rate, new_lanes, new_bw);
+		tb_tunnel_dbg(tunnel,
+			      "bandwidth reduced to %u Mb/s x%u = %u Mb/s\n",
+			      new_rate, new_lanes, new_bw);
 
 		/*
 		 * Set new rate and number of lanes before writing it to
@@ -662,7 +665,7 @@ static int tb_dp_xchg_caps(struct tb_tun
 	 */
 	if (tb_route(out->sw) && tb_switch_is_titan_ridge(out->sw)) {
 		out_dp_cap |= DP_COMMON_CAP_LTTPR_NS;
-		tb_port_dbg(out, "disabling LTTPR\n");
+		tb_tunnel_dbg(tunnel, "disabling LTTPR\n");
 	}
 
 	return tb_port_write(in, &out_dp_cap, TB_CFG_PORT,
@@ -712,8 +715,8 @@ static int tb_dp_bandwidth_alloc_mode_en
 	lanes = min(in_lanes, out_lanes);
 	tmp = tb_dp_bandwidth(rate, lanes);
 
-	tb_port_dbg(in, "non-reduced bandwidth %u Mb/s x%u = %u Mb/s\n", rate,
-		    lanes, tmp);
+	tb_tunnel_dbg(tunnel, "non-reduced bandwidth %u Mb/s x%u = %u Mb/s\n",
+		      rate, lanes, tmp);
 
 	ret = usb4_dp_port_set_nrd(in, rate, lanes);
 	if (ret)
@@ -728,15 +731,15 @@ static int tb_dp_bandwidth_alloc_mode_en
 	rate = min(in_rate, out_rate);
 	tmp = tb_dp_bandwidth(rate, lanes);
 
-	tb_port_dbg(in,
-		    "maximum bandwidth through allocation mode %u Mb/s x%u = %u Mb/s\n",
-		    rate, lanes, tmp);
+	tb_tunnel_dbg(tunnel,
+		      "maximum bandwidth through allocation mode %u Mb/s x%u = %u Mb/s\n",
+		      rate, lanes, tmp);
 
 	for (granularity = 250; tmp / granularity > 255 && granularity <= 1000;
 	     granularity *= 2)
 		;
 
-	tb_port_dbg(in, "granularity %d Mb/s\n", granularity);
+	tb_tunnel_dbg(tunnel, "granularity %d Mb/s\n", granularity);
 
 	/*
 	 * Returns -EINVAL if granularity above is outside of the
@@ -756,7 +759,7 @@ static int tb_dp_bandwidth_alloc_mode_en
 	else
 		estimated_bw = tunnel->max_up;
 
-	tb_port_dbg(in, "estimated bandwidth %d Mb/s\n", estimated_bw);
+	tb_tunnel_dbg(tunnel, "estimated bandwidth %d Mb/s\n", estimated_bw);
 
 	ret = usb4_dp_port_set_estimated_bandwidth(in, estimated_bw);
 	if (ret)
@@ -767,7 +770,7 @@ static int tb_dp_bandwidth_alloc_mode_en
 	if (ret)
 		return ret;
 
-	tb_port_dbg(in, "bandwidth allocation mode enabled\n");
+	tb_tunnel_dbg(tunnel, "bandwidth allocation mode enabled\n");
 	return 0;
 }
 
@@ -788,7 +791,7 @@ static int tb_dp_init(struct tb_tunnel *
 	if (!usb4_dp_port_bandwidth_mode_supported(in))
 		return 0;
 
-	tb_port_dbg(in, "bandwidth allocation mode supported\n");
+	tb_tunnel_dbg(tunnel, "bandwidth allocation mode supported\n");
 
 	ret = usb4_dp_port_set_cm_id(in, tb->index);
 	if (ret)
@@ -805,7 +808,7 @@ static void tb_dp_deinit(struct tb_tunne
 		return;
 	if (usb4_dp_port_bandwidth_mode_enabled(in)) {
 		usb4_dp_port_set_cm_bandwidth_mode_supported(in, false);
-		tb_port_dbg(in, "bandwidth allocation mode disabled\n");
+		tb_tunnel_dbg(tunnel, "bandwidth allocation mode disabled\n");
 	}
 }
 
@@ -921,9 +924,6 @@ static int tb_dp_bandwidth_mode_consumed
 	if (allocated_bw == max_bw)
 		allocated_bw = ret;
 
-	tb_port_dbg(in, "consumed bandwidth through allocation mode %d Mb/s\n",
-		    allocated_bw);
-
 	if (in->sw->config.depth < out->sw->config.depth) {
 		*consumed_up = 0;
 		*consumed_down = allocated_bw;
@@ -1006,9 +1006,6 @@ static int tb_dp_alloc_bandwidth(struct
 	/* Now we can use BW mode registers to figure out the bandwidth */
 	/* TODO: need to handle discovery too */
 	tunnel->bw_mode = true;
-
-	tb_port_dbg(in, "allocated bandwidth through allocation mode %d Mb/s\n",
-		    tmp);
 	return 0;
 }
 
@@ -1035,8 +1032,7 @@ static int tb_dp_read_dprx(struct tb_tun
 			*rate = tb_dp_cap_get_rate(val);
 			*lanes = tb_dp_cap_get_lanes(val);
 
-			tb_port_dbg(in, "consumed bandwidth through DPRX %d Mb/s\n",
-				    tb_dp_bandwidth(*rate, *lanes));
+			tb_tunnel_dbg(tunnel, "DPRX read done\n");
 			return 0;
 		}
 		usleep_range(100, 150);
@@ -1073,9 +1069,6 @@ static int tb_dp_read_cap(struct tb_tunn
 
 	*rate = tb_dp_cap_get_rate(val);
 	*lanes = tb_dp_cap_get_lanes(val);
-
-	tb_port_dbg(in, "bandwidth from %#x capability %d Mb/s\n", cap,
-		    tb_dp_bandwidth(*rate, *lanes));
 	return 0;
 }
 
@@ -1253,8 +1246,9 @@ static void tb_dp_dump(struct tb_tunnel
 	rate = tb_dp_cap_get_rate(dp_cap);
 	lanes = tb_dp_cap_get_lanes(dp_cap);
 
-	tb_port_dbg(in, "maximum supported bandwidth %u Mb/s x%u = %u Mb/s\n",
-		    rate, lanes, tb_dp_bandwidth(rate, lanes));
+	tb_tunnel_dbg(tunnel,
+		      "DP IN maximum supported bandwidth %u Mb/s x%u = %u Mb/s\n",
+		      rate, lanes, tb_dp_bandwidth(rate, lanes));
 
 	out = tunnel->dst_port;
 
@@ -1265,8 +1259,9 @@ static void tb_dp_dump(struct tb_tunnel
 	rate = tb_dp_cap_get_rate(dp_cap);
 	lanes = tb_dp_cap_get_lanes(dp_cap);
 
-	tb_port_dbg(out, "maximum supported bandwidth %u Mb/s x%u = %u Mb/s\n",
-		    rate, lanes, tb_dp_bandwidth(rate, lanes));
+	tb_tunnel_dbg(tunnel,
+		      "DP OUT maximum supported bandwidth %u Mb/s x%u = %u Mb/s\n",
+		      rate, lanes, tb_dp_bandwidth(rate, lanes));
 
 	if (tb_port_read(in, &dp_cap, TB_CFG_PORT,
 			 in->cap_adap + DP_REMOTE_CAP, 1))
@@ -1275,8 +1270,8 @@ static void tb_dp_dump(struct tb_tunnel
 	rate = tb_dp_cap_get_rate(dp_cap);
 	lanes = tb_dp_cap_get_lanes(dp_cap);
 
-	tb_port_dbg(in, "reduced bandwidth %u Mb/s x%u = %u Mb/s\n",
-		    rate, lanes, tb_dp_bandwidth(rate, lanes));
+	tb_tunnel_dbg(tunnel, "reduced bandwidth %u Mb/s x%u = %u Mb/s\n",
+		      rate, lanes, tb_dp_bandwidth(rate, lanes));
 }
 
 /**



